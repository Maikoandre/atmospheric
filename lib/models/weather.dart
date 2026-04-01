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

  factory Weather.fromJson(Map<String, dynamic> json){
    return Weather( 
      cityName: json['name'] ?? '', 
      temperature: json['main']['temp']?.toDouble() ?? 0.0, 
      mainCondition: json['weather'][0]['main'] ?? '',
      humidity: json['main']['humidity']?.toInt() ?? 0,
      windSpeed: json['wind']['speed']?.toDouble() ?? 0.0,
      pressure: json['main']['pressure']?.toInt() ?? 0,
      visibility: json['visibility'].toInt() ?? 0,
    );
  }
}
