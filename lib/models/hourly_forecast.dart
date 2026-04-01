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