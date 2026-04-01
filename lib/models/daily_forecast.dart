class DailyForecast {
  final int dt;
  final double minTemp;
  final double maxTemp;
  final String mainCondition;
  final String icon;

  DailyForecast({
    required this.dt,
    required this.minTemp,
    required this.maxTemp,
    required this.mainCondition,
    required this.icon,
  });
}