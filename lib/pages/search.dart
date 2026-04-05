import 'package:flutter/material.dart';

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
                            color: const Color(
                              0xFF181C21,
                            ).withValues(alpha: 0.6), // on-surface com opacidade
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
            ],
          ),
        ),
      ),
    );
  }
}


Widget _buildRecentItem(String city, String country, String temp, String status) {
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
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Color(0xFF414752)),
            ),
          ],
        ),
      ],
    ),
  );
}