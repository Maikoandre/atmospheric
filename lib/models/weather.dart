import 'daily_forecast.dart';
import 'hourly_forecast.dart';

class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final int visibility;
  final List<HourlyForecast> hourly;
  final List<DailyForecast> daily;
  final double uvIndex;
  final int sunrise;
  final int sunset;
  final int aqi;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.visibility,
    this.hourly = const [],
    this.daily = const [],
    this.uvIndex = 0.0,
    this.sunrise = 0,
    this.sunset = 0,
    this.aqi = 0,
  });

  factory Weather.fromJson(Map<String, dynamic> json, {String cityName = ''}) {
    List<HourlyForecast> hourlyList = [];
    if (json['hourly'] != null) {
      hourlyList = (json['hourly'] as List).map((i) => HourlyForecast.fromJson(i)).toList();
    }

    List<DailyForecast> dailyList = [];
    if (json['daily'] != null) {
      dailyList = (json['daily'] as List).map((i) => DailyForecast(
        dt: i['dt'],
        minTemp: i['temp']['min'].toDouble(),
        maxTemp: i['temp']['max'].toDouble(),
        mainCondition: i['weather'][0]['main'],
        icon: i['weather'][0]['icon'],
      )).toList();
    } else {
      Map<String, List<HourlyForecast>> groupedByDay = {};
      for (var forecast in hourlyList) {
        DateTime dt = DateTime.fromMillisecondsSinceEpoch(forecast.dt * 1000);
        String dayKey = '${dt.year}-${dt.month}-${dt.day}';
        groupedByDay.putIfAbsent(dayKey, () => []).add(forecast);
      }
      
      groupedByDay.forEach((dayKey, forecasts) {
        double minTemp = forecasts.map((f) => f.temp).reduce((a, b) => a < b ? a : b);
        double maxTemp = forecasts.map((f) => f.temp).reduce((a, b) => a > b ? a : b);
        
        var midDayForecast = forecasts.firstWhere(
          (f) => DateTime.fromMillisecondsSinceEpoch(f.dt * 1000).hour >= 12, 
          orElse: () => forecasts.first
        );
        
        dailyList.add(DailyForecast(
          dt: forecasts.first.dt,
          minTemp: minTemp,
          maxTemp: maxTemp,
          mainCondition: midDayForecast.mainCondition,
          icon: midDayForecast.icon,
        ));
      });
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
        daily: dailyList,
        uvIndex: json['current']['uvi']?.toDouble() ?? 0.0,
        sunrise: json['current']['sunrise']?.toInt() ?? 0,
        sunset: json['current']['sunset']?.toInt() ?? 0,
        aqi: json['aqi']?.toInt() ?? 0,
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
        daily: dailyList,
        uvIndex: json['uvi']?.toDouble() ?? 0.0,
        sunrise: json['sys']?['sunrise']?.toInt() ?? 0,
        sunset: json['sys']?['sunset']?.toInt() ?? 0,
        aqi: json['aqi']?.toInt() ?? 0,
      );
    }
  }
}
