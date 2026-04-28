import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:atmospheric/models/weather.dart';
import 'package:atmospheric/services/weather_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService(dotenv.env['API_KEY'] ?? '');
  final Logger _logger = Logger();

  Weather? _weather;
  bool _isLoading = false;
  List<String> _recentSearches = [];
  final Map<String, Weather> _recentWeather = {};
  int _selectedIndex = 0;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  List<String> get recentSearches => _recentSearches;
  Map<String, Weather> get recentWeather => _recentWeather;
  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Future<void> init() async {
    await fetchWeatherForCurrentLocation();
    await loadRecentSearches();
  }

  Future<void> fetchWeatherForCurrentLocation() async {
    _isLoading = true;
    notifyListeners();
    try {
      _weather = await _weatherService.getWeatherForCurrentLocation();
      _selectedIndex = 0;
    } catch (e) {
      _logger.e("Failed to fetch initial weather data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateCity(String newCity) async {
    if (newCity.isEmpty) return;
    _isLoading = true;
    notifyListeners();
    try {
      if (newCity == '__CURRENT_LOCATION__') {
        await fetchWeatherForCurrentLocation();
        return;
      }
      _weather = await _weatherService.getWeather(newCity);
      _selectedIndex = 0;
      await saveRecentSearch(newCity);
    } catch (e) {
      _logger.e("Failed to fetch weather data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    _recentSearches = prefs.getStringList('recent_searches') ?? [];
    notifyListeners();
    _fetchRecentWeather();
  }

  Future<void> _fetchRecentWeather() async {
    for (var city in _recentSearches) {
      try {
        final w = await _weatherService.getWeather(city);
        _recentWeather[city] = w;
        notifyListeners();
      } catch (e) {
        // Ignore failure
      }
    }
  }

  Future<void> saveRecentSearch(String city) async {
    if (city.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    List<String> searches = prefs.getStringList('recent_searches') ?? [];
    
    searches.removeWhere((s) => s.toLowerCase() == city.toLowerCase());
    searches.insert(0, city);
    
    if (searches.length > 5) {
      searches = searches.sublist(0, 5);
    }
    
    await prefs.setStringList('recent_searches', searches);
    _recentSearches = searches;
    notifyListeners();
    _fetchRecentWeather();
  }

  Future<void> clearRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('recent_searches');
    _recentSearches = [];
    _recentWeather.clear();
    notifyListeners();
  }
}
