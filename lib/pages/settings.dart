import 'package:atmospheric/components/app_bar.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FF), // surface-bright
      appBar: const CustomAppBar(
        title: 'Settings',
      ), // Reutilizando seu componente
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Personalize your weather experience',
              style: TextStyle(color: Color(0xFF414752), fontSize: 14),
            ),
            const SizedBox(height: 32),

            // Seções de Configuração
            _buildSectionHeader('APPEARANCE'),
            _buildSettingTile(
              title: 'Dark Mode',
              subtitle: 'Follow system theme',
              icon: Icons.dark_mode,
              trailing: Switch(value: true, onChanged: (v) {}),
            ),

            const SizedBox(height: 32),
            _buildSectionHeader('UNITS'),
            _buildUnitSelector('Temperature', [
              'Celsius (°C)',
              'Fahrenheit (°F)',
            ]),
            const SizedBox(height: 12),
            _buildUnitSelector('Distance & Wind', [
              'Metric (km/h)',
              'Imperial (mph)',
            ]),
          ],
        ),
      ),
    );
  }
}

Widget _buildSectionHeader(String title) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, bottom: 12.0),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Color(0xFF005DAC), // primary
        letterSpacing: 1.5,
      ),
    ),
  );
}

Widget _buildUnitSelector(String title, List<String> options) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFF2F3FC), // surface-container-low
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.straighten, size: 20, color: Color(0xFF005DAC)),
            const SizedBox(width: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFE0E2EA), // surface-variant
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                  child: Center(child: Text(options[0], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                ),
              ),
              Expanded(
                child: Center(child: Text(options[1], style: const TextStyle(fontSize: 12, color: Color(0xFF414752)))),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}