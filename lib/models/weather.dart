class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final int visibility;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.visibility,
  });

  factory Weather.fromJson(Map<String, dynamic> json, {String cityName = ''}) {
    return Weather(
      cityName: cityName,
      temperature: json['current']['temp']?.toDouble() ?? 0.0,
      mainCondition: json['current']['weather'][0]['main'] ?? '',
      humidity: json['current']['humidity']?.toInt() ?? 0,
      windSpeed: json['current']['wind_speed']?.toDouble() ?? 0.0,
      pressure: json['current']['pressure']?.toInt() ?? 0,
      visibility: json['current']['visibility']?.toInt() ?? 0,
    );
  }
}
