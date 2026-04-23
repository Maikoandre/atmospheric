import 'package:flutter/material.dart';
import 'package:atmospheric/models/weather.dart';

class LocationPage extends StatefulWidget {
  final Weather? weather;
  const LocationPage({super.key, this.weather});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.weather == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final w = widget.weather!;
    String highTemp = '--', lowTemp = '--';
    if (w.daily.isNotEmpty) {
      highTemp = '${w.daily.first.maxTemp.round()}°';
      lowTemp = '${w.daily.first.minTemp.round()}°';
    }

    String sunsetTime = '--';
    String sunriseTime = '--';
    if (w.sunset > 0) {
      final sunsetDate = DateTime.fromMillisecondsSinceEpoch(w.sunset * 1000);
      int h = sunsetDate.hour % 12;
      if (h == 0) h = 12;
      String m = sunsetDate.minute.toString().padLeft(2, '0');
      sunsetTime = '$h:$m';
    }
    if (w.sunrise > 0) {
      final sunriseDate = DateTime.fromMillisecondsSinceEpoch(w.sunrise * 1000);
      int h = sunriseDate.hour;
      String m = sunriseDate.minute.toString().padLeft(2, '0');
      sunriseTime = 'Sunrise: $h:$m AM';
    }
    
    String uvLevel = 'Low';
    if (w.uvIndex > 2) uvLevel = 'Moderate';
    if (w.uvIndex > 5) uvLevel = 'High';
    if (w.uvIndex > 7) uvLevel = 'Very High';
    if (w.uvIndex > 10) uvLevel = 'Extreme';
    double uvProgress = w.uvIndex / 11;
    if (uvProgress > 1.0) uvProgress = 1.0;
    
    String aqiLevel = 'Unknown';
    if (w.aqi == 1) {
      aqiLevel = 'Good';
    } else if (w.aqi == 2) aqiLevel = 'Fair';
    else if (w.aqi == 3) aqiLevel = 'Moderate';
    else if (w.aqi == 4) aqiLevel = 'Poor';
    else if (w.aqi == 5) aqiLevel = 'Very Poor';
    
    String aqiDesc = 'No data available.';
    if (w.aqi == 1) {
      aqiDesc = 'The air quality is ideal for most individuals; enjoy your normal outdoor activities.';
    } else if (w.aqi == 2) aqiDesc = 'Air quality is acceptable; however, there may be a risk for some people.';
    else if (w.aqi == 3) aqiDesc = 'Members of sensitive groups may experience health effects.';
    else if (w.aqi == 4) aqiDesc = 'Everyone may begin to experience health effects; sensitive groups may experience more serious effects.';
    else if (w.aqi == 5) aqiDesc = 'Health warnings of emergency conditions. The entire population is more likely to be affected.';

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // Define a altura e preenchimento para dar espaço aos elementos
              padding: const EdgeInsets.only(
                top: 80,
                bottom: 64,
                left: 24,
                right: 24,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                // Replicando o gradiente do seu CSS (.glass-header)
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF005DAC), // primary
                    Color(0xFF1976D2), // primary-container
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    w.cityName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily:
                          'Plus Jakarta Sans', // Usando a fonte do projeto
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    w.mainCondition.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 14,
                      letterSpacing:
                          2.0, // Replicando o tracking-widest do Tailwind
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Row para alinhar o número e o símbolo de grau
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${w.temperature.round()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 112, // Tamanho aproximado do 7rem
                          fontWeight: FontWeight.w800,
                          height: 1.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: const Text(
                          '°',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -32), // Faz o card sobrepor o header azul
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(32), // rounded-[2rem]
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Cabeçalho do Card
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hourly Forecast',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface, // on-surface
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule, size: 14, color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Next 24 Hours',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: const Color(
                                    0xFF414752,
                                  ).withValues(alpha: 0.8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),


                      // Lista de Horas (Scroll Horizontal)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: w.hourly.take(24).map((h) {
                            String timeStr = 'Now';
                            if (w.hourly.indexOf(h) > 0) {
                              final time = DateTime.fromMillisecondsSinceEpoch(h.dt * 1000);
                              int hour = time.hour;
                              String period = hour >= 12 ? 'PM' : 'AM';
                              hour = hour % 12;
                              if (hour == 0) hour = 12;
                              timeStr = '$hour $period';
                            }
                            
                            IconData icon = Icons.cloud;
                            bool isSunny = h.mainCondition.toLowerCase() == 'clear';
                            if (isSunny) {
                              icon = Icons.wb_sunny;
                            } else if (h.mainCondition.toLowerCase() == 'rain') icon = Icons.umbrella;
                            else if (h.mainCondition.toLowerCase() == 'clouds') icon = Icons.wb_cloudy;
                            
                            return _buildHourlyItem(context, timeStr,
                              icon,
                              '${h.temp.round()}°',
                              isSunny: isSunny,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: GridView.count(
                shrinkWrap:
                    true, // Permite que o Grid ocupe apenas o espaço necessário
                physics:
                    const NeverScrollableScrollPhysics(), // Evita conflito de rolagem
                crossAxisCount: 2, // 2 colunas como no design
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1, // Mantém o formato retangular dos cards
                children: [
                  _buildMetricCard(
                    context,
                    'UV INDEX',
                    w.uvIndex.toString(),
                    uvLevel,
                    Icons.light_mode,
                    hasBar: true,
                    barProgress: uvProgress,
                  ),
                  _buildMetricCard(
                    context,
                    'SUNSET',
                    sunsetTime,
                    sunriseTime,
                    Icons.wb_twilight,
                    hasSunLine: true,
                  ),
                  _buildMetricCard(
                    context,
                    'HUMIDITY',
                    '${w.humidity}%',
                    'Current Humidity',
                    Icons.percent_sharp,
                  ),
                  _buildMetricCard(
                    context,
                    'PRESSURE',
                    '${w.pressure}',
                    'hPa',
                    Icons.speed,
                  ),
                ],
              ),
            ),
            // Espaçamento entre o Grid e a Previsão Semanal
            const SizedBox(height: 32),

            // --- SEÇÃO 7-DAY FORECAST ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(32), // rounded-[2rem]
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.onSurface.withAlpha(51),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '5-Day Forecast',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ...(() {
                      double absMin = 1000;
                      double absMax = -1000;
                      if (w.daily.isNotEmpty) {
                        absMin = w.daily.take(5).map((d) => d.minTemp).reduce((a, b) => a < b ? a : b);
                        absMax = w.daily.take(5).map((d) => d.maxTemp).reduce((a, b) => a > b ? a : b);
                      }
                      double range = absMax - absMin;
                      if (range == 0) range = 1;
                      
                      return w.daily.take(5).map((d) {
                        String dayStr = 'Today';
                        final now = DateTime.now();
                        final time = DateTime.fromMillisecondsSinceEpoch(d.dt * 1000);
                        if (now.year != time.year || now.month != time.month || now.day != time.day) {
                          const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                          dayStr = days[time.weekday - 1];
                        }
                        
                        IconData icon = Icons.cloud;
                        Color color = Colors.blueGrey;
                        if (d.mainCondition.toLowerCase() == 'clear') { icon = Icons.wb_sunny; color = Colors.blue; }
                        else if (d.mainCondition.toLowerCase() == 'rain') { icon = Icons.umbrella; color = Colors.blue; }
                        else if (d.mainCondition.toLowerCase() == 'clouds') { icon = Icons.wb_cloudy; color = Colors.blueGrey; }
                        
                        double start = (d.minTemp - absMin) / range;
                        double end = (d.maxTemp - absMin) / range;

                        return _buildForecastRow(context, dayStr,
                          icon,
                          d.maxTemp.round(),
                          d.minTemp.round(),
                          start,
                          end,
                          color,
                        );
                      });
                    })(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- SEÇÃO AIR QUALITY ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer, // surface-container-low
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.air, size: 14, color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'AIR QUALITY',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${w.aqi} - $aqiLevel',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      aqiDesc,
                      style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Barra de progresso da qualidade do ar
                    Container(
                      height: 8,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: ((6 - w.aqi) / 5.0).clamp(0.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF005DAC),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ), // Espaço final para não colar na barra de navegação
          ],
        ),
      ),
    );
  }
}

Widget _buildHourlyItem(BuildContext context, String time,
  IconData icon,
  String temp, {
  bool isSunny = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 32.0),
    child: Column(
      children: [
        Text(
          time,
          style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 12),
        Icon(
          icon,
          color: isSunny
              ? const Color(0xFF005DAC)
              : const Color(0xFF95CFFF), // primary vs secondary-container
          size: 24,
        ),
        const SizedBox(height: 12),
        Text(
          temp,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget _buildMetricCard(
  BuildContext context,
  String title,
  String value,
  String subtitle,
  IconData icon, {
  bool hasBar = false,
  double barProgress = 0.0,
  bool hasSunLine = false,
}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainer, // surface-container-low
      borderRadius: BorderRadius.circular(24), // rounded-[1.5rem]
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ],
        ),
        // Elementos visuais extras (Barra de UV ou Linha de Sunset)
        if (hasBar)
          Container(
            height: 4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: barProgress,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF765800), // tertiary
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          )
        else if (hasSunLine)
          Container(
            height: 2,
            width: double.infinity,
            color: const Color(0xFFFFDF9E), // tertiary-fixed
          )
        else
          const SizedBox(height: 4),
      ],
    ),
  );
}

Widget _buildForecastRow(BuildContext context, String day, IconData icon, int high, int low, double start, double end, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 50,
          child: Text(day, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        ),
        Icon(icon, color: color, size: 22),
        // Barra de variação de temperatura
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest, // surface-container
                borderRadius: BorderRadius.circular(3),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 100 * start, // Simula a posição baseada na escala
                    right: 100 * (1 - end),
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: const Color(0xFF005DAC),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          children: [
            Text('$high°', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(width: 8),
            Text('$low°', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 14)),
          ],
        ),
      ],
    ),
  );
}