class HourlyForecast {
  final int dt;
  final double temp;
  final String mainCondition;
  final String icon;

  HourlyForecast({
    required this.dt,
    required this.temp,
    required this.mainCondition,
    required this.icon,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      dt: json['dt'] ?? 0,
      temp: json['temp']?.toDouble() ?? json['main']?['temp']?.toDouble() ?? 0.0,
      mainCondition: json['weather'] != null && json['weather'].isNotEmpty ? json['weather'][0]['main'] : '',
      icon: json['weather'] != null && json['weather'].isNotEmpty ? json['weather'][0]['icon'] : '',
    );
  }
}

class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final int visibility;
  final List<HourlyForecast> hourly;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.visibility,
    this.hourly = const [],
  });

  factory Weather.fromJson(Map<String, dynamic> json, {String cityName = ''}) {
    List<HourlyForecast> hourlyList = [];
    if (json['hourly'] != null) {
      hourlyList = (json['hourly'] as List).map((i) => HourlyForecast.fromJson(i)).toList();
    }

    // Check if it's the One Call structure (has 'current' key)
    if (json['current'] != null) {
      return Weather(
        cityName: cityName,
        temperature: json['current']['temp']?.toDouble() ?? 0.0,
        mainCondition: json['current']['weather'][0]['main'] ?? '',
        humidity: json['current']['humidity']?.toInt() ?? 0,
        windSpeed: json['current']['wind_speed']?.toDouble() ?? 0.0,
        pressure: json['current']['pressure']?.toInt() ?? 0,
        visibility: json['current']['visibility']?.toInt() ?? 0,
        hourly: hourlyList,
      );
    } else {
      // Fallback to standard 2.5/weather API structure
      return Weather(
        cityName: json['name'] ?? cityName,
        temperature: json['main']?['temp']?.toDouble() ?? 0.0,
        mainCondition: json['weather'] != null && json['weather'].isNotEmpty ? json['weather'][0]['main'] : '',
        humidity: json['main']?['humidity']?.toInt() ?? 0,
        windSpeed: json['wind']?['speed']?.toDouble() ?? 0.0,
        pressure: json['main']?['pressure']?.toInt() ?? 0,
        visibility: json['visibility']?.toInt() ?? 0,
        hourly: hourlyList, // Properly pass the injected hourly data
      );
    }
  }
}
