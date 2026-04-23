import 'package:flutter/material.dart';
import 'package:atmospheric/main.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:atmospheric/services/weather_service.dart';
import 'package:atmospheric/models/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchPage extends StatefulWidget {
  final Function(String)? onCitySelected;
  const SearchPage({super.key, this.onCitySelected});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _recentSearches = [];
  Map<String, Weather> _recentWeather = {};

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    final searches = prefs.getStringList('recent_searches') ?? [];
    if (mounted) {
      setState(() {
        _recentSearches = searches;
      });
    }
    _fetchRecentWeather(searches);
  }

  Future<void> _fetchRecentWeather(List<String> searches) async {
    final w = WeatherService(dotenv.env['API_KEY'] ?? '');
    for (var city in searches) {
      try {
        final weather = await w.getWeather(city);
        if (mounted) {
          setState(() {
            _recentWeather[city] = weather;
          });
        }
      } catch (e) {
        // Ignore failure for a specific recent city
      }
    }
  }

  Future<void> _saveRecentSearch(String city) async {
    if (city.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    List<String> searches = prefs.getStringList('recent_searches') ?? [];
    
    // Remove if exists to push it to the top
    searches.removeWhere((s) => s.toLowerCase() == city.toLowerCase());
    searches.insert(0, city);
    
    // Limit to 5 recent searches
    if (searches.length > 5) {
      searches = searches.sublist(0, 5);
    }
    
    await prefs.setStringList('recent_searches', searches);
    if (mounted) {
      setState(() {
        _recentSearches = searches;
      });
    }
  }

  void _submitSearch(String city) {
    if (city.isNotEmpty) {
      _saveRecentSearch(city);
      if (widget.onCitySelected != null) {
        widget.onCitySelected!(city);
      }
    }
  }

  Future<void> _useCurrentLocation() async {
    try {
      if (widget.onCitySelected != null) {
        widget.onCitySelected!('__CURRENT_LOCATION__');
      }
    } catch (e) {
      // ignore
    }
  }

  Future<void> _clearRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('recent_searches');
    if (mounted) {
      setState(() {
        _recentSearches = [];
        _recentWeather.clear();
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              // Campo de entrada de texto
              TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onSubmitted: _submitSearch,
                decoration: InputDecoration(
                  hintText: 'Search city or zip code',
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 16,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainer,
                  contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999), // Formato pílula
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Botão "Current Location"
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _useCurrentLocation,
                  icon: const Icon(Icons.my_location, size: 20),
                  label: const Text('Current Location'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    elevation: 4,
                    shadowColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cabeçalho da Seção
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'RECENT SEARCHES',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                            letterSpacing: 1.5,
                          ),
                        ),
                        TextButton(
                          onPressed: _clearRecentSearches,
                          child: Text(
                            'Clear all',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Lista de Itens Recentes
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: _recentSearches.isEmpty
                        ? Text('No recent searches', style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)))
                        : Column(
                            children: _recentSearches.map((city) {
                              final w = _recentWeather[city];
                              final temp = w != null ? '${Main.formatTemp(w.temperature)}' : '';
                              final status = w != null ? w.mainCondition : '';
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () => _submitSearch(city),
                                  child: _buildRecentItem(
                                    context,
                                    city,
                                    'Saved',
                                    temp,
                                    status,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título da Seção
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Text(
                      'SUGGESTED CITIES',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),

                  // Grid de Cidades Sugeridas
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2, // 2 colunas como no grid-cols-2
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio:
                          0.85, // Ajusta a proporção para o card ficar alto
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: () => _submitSearch('Paris'),
                          child: _buildSuggestedCard(
                            'Paris',
                            'France',
                            'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?q=80&w=500',
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: () => _submitSearch('New York'),
                          child: _buildSuggestedCard(
                            'New York',
                            'USA',
                            'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?q=80&w=500',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 32.0,
                ),
                child: Container(
                  height: 160, // Altura h-40 do seu HTML
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      // Imagem do Mapa em Tons de Cinza
                      Opacity(
                        opacity: 0.4,
                        child: ColorFiltered(
                          colorFilter: const ColorFilter.matrix([
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0.2126,
                            0.7152,
                            0.0722,
                            0,
                            0,
                            0,
                            0,
                            0,
                            1,
                            0,
                          ]), // Efeito grayscale do Tailwind
                          child: Image.network(
                            'https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?q=80&w=1000',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),

                      // Botão Centralizado com Efeito Glassmorphism
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(99),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10,
                              sigmaY: 10,
                            ), // backdrop-blur-md
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surfaceContainerHigh.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(99),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.explore,
                                    color: Theme.of(context).colorScheme.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Explore Map',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildRecentItem(
  BuildContext context,
  String city,
  String country,
  String temp,
  String status,
) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.history, color: Theme.of(context).colorScheme.primary, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                city,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                country,
                style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              temp,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              status.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildSuggestedCard(String city, String country, String imageUrl) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24), // rounded-2xl
      color: const Color(0xFFF2F3FC),
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      fit: StackFit.expand,
      children: [
        // Imagem de fundo com opacidade
        Opacity(
          opacity: 0.8,
          child: Image.network(imageUrl, fit: BoxFit.cover),
        ),

        // Gradiente para o texto não sumir na imagem
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.8), // bg-gradient-to-t
              ],
            ),
          ),
        ),

        // Textos posicionados na parte inferior
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                city,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                country,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
