import 'package:flutter/material.dart';
import \'package:atmospheric/theme/app_colors.dart\';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:atmospheric/models/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapPage extends StatefulWidget {
  final List<Weather> recentWeathers;

  const MapPage({super.key, this.recentWeathers = const []});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String _selectedLayer = 'temp_new';

  final Map<String, String> _layers = {
    'temp_new': 'Temperatura',
    'precipitation_new': 'Precipitação',
    'clouds_new': 'Nuvens',
    'wind_new': 'Vento',
    'pressure_new': 'Pressão',
  };

  @override
  Widget build(BuildContext context) {
    final apiKey = dotenv.env['API_KEY'] ?? '';

    // Define initial center based on recent weathers or default to world view
    LatLng center = const LatLng(20.0, 0.0);
    double zoom = 2.0;

    if (widget.recentWeathers.isNotEmpty) {
      final firstWeather = widget.recentWeathers.first;
      if (firstWeather.lat != 0.0 || firstWeather.lon != 0.0) {
        center = LatLng(firstWeather.lat, firstWeather.lon);
        zoom = 5.0; // Zoom closer if we have a city
      }
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Mapa de Clima',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.surface(context)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.surface(context)),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: center,
          initialZoom: zoom,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.atmospheric',
          ),
          if (apiKey.isNotEmpty)
            TileLayer(
              urlTemplate:
                  'https://tile.openweathermap.org/map/$_selectedLayer/{z}/{x}/{y}.png?appid=$apiKey',
              userAgentPackageName: 'com.example.atmospheric',
            ),
          MarkerLayer(
            markers: widget.recentWeathers.where((w) => w.lat != 0.0 || w.lon != 0.0).map((w) {
              return Marker(
                point: LatLng(w.lat, w.lon),
                width: 80,
                height: 80,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.primary(context),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${w.temperature.round()}°',
                        style: TextStyle(color: AppColors.surface(context),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.location_on, color: AppColors.primary(context),
                      size: 30,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary(context),
        onPressed: () {
          _showLayerSelector(context);
        },
        icon: Icon(Icons.layers, color: AppColors.surface(context)),
        label: Text(
          _layers[_selectedLayer] ?? 'Camada',
          style: TextStyle(color: AppColors.surface(context)),
        ),
      ),
    );
  }

  void _showLayerSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Selecione a Camada',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ..._layers.entries.map((entry) {
                return ListTile(
                  title: Text(entry.value),
                  trailing: _selectedLayer == entry.key
                      ? Icon(Icons.check, color: AppColors.primary(context))
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedLayer = entry.key;
                    });
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
