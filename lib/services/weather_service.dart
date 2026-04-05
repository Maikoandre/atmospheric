import 'dart:convert';
import 'package:atmospheric/models/weather.dart';
import 'package:atmospheric/pages/home.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  // ignore: constant_identifier_names
  static const BASE_URL = "https://api.openweathermap.org/data/2.5";
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    if (cityName.isEmpty) {
      throw Exception(
        'Nome da cidade está vazio. Verifique as permissões de GPS.',
      );
    }

    List<Location> locations = await locationFromAddress(cityName);
    if (locations.isEmpty) {
      throw Exception('Could not find location for city: $cityName');
    }
    
    double lat = locations.first.latitude;
    double lon = locations.first.longitude;

    final weatherResponse = await http.get(
      Uri.parse('$BASE_URL/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'),
    );

    final forecastResponse = await http.get(
      Uri.parse('$BASE_URL/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric'),
    );

    final airQualityResponse = await http.get(
      Uri.parse('$BASE_URL/air_pollution?lat=$lat&lon=$lon&appid=$apiKey'),
    );

    final uvResponse = await http.get(
      Uri.parse('$BASE_URL/uvi?lat=$lat&lon=$lon&appid=$apiKey'),
    );

    if (weatherResponse.statusCode == 200 && forecastResponse.statusCode == 200) {
      final weatherJson = jsonDecode(weatherResponse.body);
      final forecastJson = jsonDecode(forecastResponse.body);
      weatherJson['hourly'] = forecastJson['list'];
      
      if (airQualityResponse.statusCode == 200) {
        final airQualityJson = jsonDecode(airQualityResponse.body);
        if (airQualityJson['list'] != null && airQualityJson['list'].isNotEmpty) {
          weatherJson['aqi'] = airQualityJson['list'][0]['main']['aqi'];
        }
      } else {
        logger.e("Failed to fetch air quality data: ${airQualityResponse.statusCode}");
      }

      if (uvResponse.statusCode == 200) {
        final uvJson = jsonDecode(uvResponse.body);
        weatherJson['uvi'] = uvJson['value'];
      } else {
        logger.e("Failed to fetch UV data: ${uvResponse.statusCode}");
      }
      
      return Weather.fromJson(weatherJson, cityName: cityName);
    } else {
      logger.e("Failed to fetch weather data: ${weatherResponse.statusCode} - ${weatherResponse.body}");
      logger.e("Failed to fetch forecast data: ${forecastResponse.statusCode} - ${forecastResponse.body}");
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Permissão negada permanentemente');
    }

    final locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isEmpty) return "";

    logger.i("Coordenadas: ${position.latitude}, ${position.longitude}");
    logger.i("Placemark encontrado: ${placemarks.first.toString()}");

    // lib/services/weather_service.dart

    // ... dentro do método getCurrentCity()
    final place = placemarks.first;

    // Tenta obter o nome da cidade seguindo uma hierarquia de campos
    String? city =
        place
            .subAdministrativeArea ?? // Geralmente contém o município (ex: Guanambi)
        place.locality ?? // Cidade principal
        place.subLocality ?? // Distrito ou bairro (ex: Ceraíma)
        place.administrativeArea; // Estado (em último caso)

    return city ?? "";
  }
}
