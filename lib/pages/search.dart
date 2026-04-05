import 'package:flutter/material.dart';
import 'dart:ui';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
                decoration: InputDecoration(
                  hintText: 'Search city or zip code',
                  hintStyle: const TextStyle(
                    color: Color(0xFF414752),
                    fontSize: 16,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF414752),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFECEDF6), // surface-container
                  contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999), // Formato pílula
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                    borderSide: const BorderSide(
                      color: Color(0xFF005DAC),
                      width: 2,
                    ), // Cor primária
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Botão "Current Location"
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.my_location, size: 20),
                  label: const Text('Current Location'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF005DAC), // primary
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: const Color(0xFF005DAC).withValues(alpha: 0.3),
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
                            color: const Color(0xFF181C21).withValues(
                              alpha: 0.6,
                            ), // on-surface com opacidade
                            letterSpacing: 1.5,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Clear all',
                            style: TextStyle(
                              color: Color(0xFF005DAC),
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
                    child: Column(
                      children: [
                        _buildRecentItem(
                          'London',
                          'United Kingdom',
                          '12°',
                          'Cloudy',
                        ),
                        const SizedBox(height: 12),
                        _buildRecentItem('Tokyo', 'Japan', '19°', 'Clear'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título da Seção
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Text(
                      'SUGGESTED CITIES',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
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
                        _buildSuggestedCard(
                          'Paris',
                          'France',
                          'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?q=80&w=500',
                        ),
                        _buildSuggestedCard(
                          'New York',
                          'USA',
                          'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?q=80&w=500',
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
                    color: const Color(0xFFF2F3FC), // surface-container-low
                    borderRadius: BorderRadius.circular(32), // rounded-3xl
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
                                color: Colors.white.withValues(
                                  alpha: 0.8,
                                ), // bg-surface-container-lowest/90
                                borderRadius: BorderRadius.circular(99),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.explore,
                                    color: Color(0xFF005DAC),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Explore Map',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF181C21), // on-surface
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
  String city,
  String country,
  String temp,
  String status,
) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFF2F3FC), // surface-container-low
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        // Ícone de Histórico circular
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Color(0xFFE0E2EA), // surface-container-highest
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.history, color: Color(0xFF005DAC), size: 20),
        ),
        const SizedBox(width: 16),

        // Nome da Cidade e País
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                city,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                country,
                style: const TextStyle(fontSize: 12, color: Color(0xFF414752)),
              ),
            ],
          ),
        ),

        // Temperatura e Status
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              temp,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF005DAC),
              ),
            ),
            Text(
              status.toUpperCase(),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Color(0xFF414752),
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
