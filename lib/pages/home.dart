import 'package:atmospheric/components/app_bar.dart';
import 'package:atmospheric/components/nav_bar.dart';
import 'package:atmospheric/models/weather.dart';
import 'package:atmospheric/models/hourly_forecast.dart';
import 'package:atmospheric/pages/location.dart';
import 'package:atmospheric/pages/search.dart';
import 'package:atmospheric/pages/settings.dart';
import 'package:atmospheric/services/weather_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';

final logger = Logger();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String apiKey = dotenv.env['API_KEY'] ?? '';

  int _selectedIndex = 0;

  List<Widget> get _pages => [
    DashboardView(weather: _weather),
    LocationPage(weather: _weather),
    const SearchPage(),
    const SettingsPage(),
  ];

  final _weatherService = WeatherService(dotenv.env['API_KEY'] ?? '');
  Weather? _weather;

  Future<void> _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } // lib/pages/home.dart
    catch (e) {
      logger.e("Failed to fetch weather data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _weather?.cityName ?? 'Atmospheric',
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomNavbar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

String _formatTime(int dt) {
  final time = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
  int hour = time.hour;
  String period = hour >= 12 ? 'PM' : 'AM';
  hour = hour % 12;
  if (hour == 0) hour = 12;
  return '$hour$period';
}

String _formatDay(int dt) {
  final now = DateTime.now();
  final time = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
  if (now.year == time.year && now.month == time.month && now.day == time.day) {
    return 'Today';
  }
  const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  return days[time.weekday - 1];
}

IconData _getWeatherIcon(String mainCondition) {
  switch (mainCondition.toLowerCase()) {
    case 'clear':
      return Icons.wb_sunny;
    case 'clouds':
      return Icons.wb_cloudy;
    case 'rain':
    case 'drizzle':
      return Icons.umbrella;
    case 'thunderstorm':
      return Icons.flash_on;
    case 'snow':
      return Icons.ac_unit;
    default:
      return Icons.cloud;
  }
}

Widget _buildBentoCard(
  String title,
  String value,
  String description,
  IconData icon,
) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFF2F3FC),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 25, color: Colors.black54),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          description,
          style: const TextStyle(fontSize: 10, color: Colors.black54),
          maxLines: 2,
        ),
      ],
    ),
  );
}

Widget _buildHourlyCard(String time, IconData icon, String temp) {
  return Container(
    width: 67,
    margin: const EdgeInsets.symmetric(horizontal: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(50),
      border: Border.all(color: Colors.black),
      boxShadow: [
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.2),
          blurRadius: 6,
          offset: const Offset(0, 0),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          time,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(height: 10),
        Icon(icon, size: 25, color: Colors.blueAccent),
        const SizedBox(height: 10),
        Text(
          temp,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        SizedBox(height: 10),
      ],
    ),
  );
}

Widget _buildDailyCard(
  String day,
  IconData icon,
  int low,
  int high,
  double start,
  double end,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 50,
          child: Text(
            day,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Icon(icon, color: Colors.blue),
        Row(
          children: [
            Text(
              '$low°',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 60 * start,
                    right: 60 * (1 - end),
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color(0xFF005DAC),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Text(
              '$high°',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class DashboardView extends StatelessWidget {
  final Weather? weather;
  const DashboardView({super.key, this.weather});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.0),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blueAccent, Colors.lightBlue],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withValues(alpha: 0.15),
                    blurRadius: 32,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weather?.cityName ?? 'Loading...',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        weather != null
                            ? '${weather!.temperature.round()}°'
                            : '--°',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -2,
                        ),
                      ),
                      Icon(
                        Icons.wb_cloudy_rounded,
                        color: Colors.white.withValues(alpha: 0.9),
                        size: 100,
                      ),
                    ],
                  ),
                  Text(
                    weather?.mainCondition ?? '--',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // const Text(
                  //   'H: 22°  L: 14°',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 1.1,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildBentoCard(
                  'HUMIDITY',
                  weather != null ? '${weather!.humidity}%' : '--%',
                  'Current relative humidity',
                  Icons.water_drop_outlined,
                ),
                _buildBentoCard(
                  'WIND',
                  weather != null ? '${weather!.windSpeed} km/h' : '-- km/h',
                  'Current wind speed',
                  Icons.air,
                ),
                _buildBentoCard(
                  'PRESSURE',
                  weather != null ? '${weather!.pressure} hPa' : '-- hPa',
                  'Atmospheric pressure',
                  Icons.speed,
                ),
                _buildBentoCard(
                  'VISIBILITY',
                  weather != null ? "${(weather!.visibility / 1000).toStringAsFixed(0)} km" : '-- km',
                  'Current visibility',
                  Icons.visibility,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16.0),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Hourly Forecast',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Next 24h',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 140,
                child: weather?.hourly != null && weather!.hourly.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: weather!.hourly.length > 24 ? 24 : weather!.hourly.length,
                        itemBuilder: (context, index) {
                          HourlyForecast forecast = weather!.hourly[index];
                          String timeStr = index == 0 ? 'Now' : _formatTime(forecast.dt);
                          return _buildHourlyCard(
                            timeStr, 
                            _getWeatherIcon(forecast.mainCondition), 
                            '${forecast.temp.round()}°'
                          );
                        },
                      )
                    : ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        children: [
                          _buildHourlyCard('Now', Icons.wb_cloudy, '--°'),
                        ],
                      ),
              ),
              SizedBox(height: 24.0),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F3FC),
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            size: 18,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            '5-Day Forecast',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withValues(alpha: 0.5),
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 32, color: Colors.black12),
                      if (weather != null && weather!.daily.isNotEmpty)
                        Builder(
                          builder: (context) {
                            double absMin = weather!.daily.map((d) => d.minTemp).reduce((a, b) => a < b ? a : b);
                            double absMax = weather!.daily.map((d) => d.maxTemp).reduce((a, b) => a > b ? a : b);
                            double range = absMax - absMin;
                            if (range == 0) range = 1;

                            return Column(
                              children: weather!.daily.map((dailyData) {
                                double start = (dailyData.minTemp - absMin) / range;
                                double end = (dailyData.maxTemp - absMin) / range;
                                return _buildDailyCard(
                                  _formatDay(dailyData.dt),
                                  _getWeatherIcon(dailyData.mainCondition),
                                  dailyData.minTemp.round(),
                                  dailyData.maxTemp.round(),
                                  start,
                                  end,
                                );
                              }).toList(),
                            );
                          },
                        )
                      else
                        const Center(child: Text('--')),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
            ],
          ),
        ],
      ),
    );
  }
}
