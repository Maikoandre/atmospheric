import 'package:atmospheric/components/app_bar.dart';
import 'package:atmospheric/components/nav_bar.dart';
import 'package:atmospheric/models/weather.dart';
import 'package:atmospheric/pages/location.dart';
import 'package:atmospheric/pages/search.dart';
import 'package:atmospheric/pages/settings.dart';
import 'package:atmospheric/services/weather_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardView(),
    const LocationPage(),
    const SearchPage(),
    const SettingsPage(),
  ];

  final _weatherService = WeatherService('');
  Weather? _weather;

  Future<void> _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    catch (e){
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  void initState(){
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
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
  const DashboardView({super.key});

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
                    _weather.cityName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '19°',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -2,
                        ),
                      ),
                      Icon(
                        Icons.wb_cloudy_outlined,
                        color: Colors.white.withValues(alpha: 0.9),
                        size: 80,
                      ),
                    ],
                  ),
                  const Text(
                    'Cloudy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'H: 22°  L: 14°',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                  '64%',
                  'The dew point is 12° right now.',
                  Icons.water_drop_outlined,
                ),
                _buildBentoCard(
                  'WIND',
                  '12 km/h',
                  'Direction: West-Northwest',
                  Icons.air,
                ),
                _buildBentoCard(
                  'FEELS LIKE',
                  '17°',
                  'Similar to the actual temperature.',
                  Icons.thermostat,
                ),
                _buildBentoCard(
                  'VISIBILITY',
                  '10 km',
                  'It\'s perfectly clear right now.',
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
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    _buildHourlyCard('Now', Icons.wb_cloudy, '19°'),
                    _buildHourlyCard('1PM', Icons.wb_sunny, '21°'),
                    _buildHourlyCard('2PM', Icons.wb_sunny, '22°'),
                    _buildHourlyCard('3PM', Icons.wb_sunny, '22°'),
                    _buildHourlyCard('4PM', Icons.wb_cloudy, '20°'),
                    _buildHourlyCard('5PM', Icons.wb_cloudy, '19°'),
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
                            '7-Day Forecast',
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
                      _buildDailyCard(
                        'Today',
                        Icons.wb_cloudy,
                        14,
                        22,
                        0.4,
                        0.9,
                      ),
                      _buildDailyCard('Tue', Icons.wb_sunny, 15, 24, 0.5, 1.0),
                      _buildDailyCard('Wed', Icons.umbrella, 12, 18, 0.1, 0.5),
                      _buildDailyCard('Thu', Icons.cloud, 13, 19, 0.3, 0.7),
                      _buildDailyCard(
                        'Fri',
                        Icons.wb_cloudy_outlined,
                        14,
                        21,
                        0.4,
                        0.8,
                      ),
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
