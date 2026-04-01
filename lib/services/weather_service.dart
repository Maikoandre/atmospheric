import 'dart:convert';

import 'package:atmospheric/models/weather.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  // ignore: constant_identifier_names
  static const BASE_URL = "https://api.openweathermap.org/data/3.0/onecall";
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

    final response = await http.get(
      Uri.parse('$BASE_URL?lat=$lat&lon=$lon&exclude=minutely,alerts&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body), cityName: cityName);
    } else {
      // Isso vai mostrar no terminal se é erro 401 (chave), 404 (cidade) ou outro.
      print("Erro da API: ${response.statusCode} - ${response.body}");
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

    print("Coordenadas: ${position.latitude}, ${position.longitude}");
    print("Placemark encontrado: ${placemarks.first.toString()}");

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
