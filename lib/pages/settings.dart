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
            // --- SEÇÃO NOTIFICATIONS ---
            const SizedBox(height: 32),
            _buildSectionHeader('NOTIFICATIONS'),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF), // surface-container-lowest
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildSettingTile(
                    title: 'Severe Weather Alerts',
                    subtitle: 'Immediate life-safety notifications',
                    icon: Icons.warning_amber_rounded,
                    iconBgColor: const Color(0xFFFFDAD6), // error-container
                    iconColor: const Color(0xFFBA1A1A), // error
                    trailing: Switch(
                      value: true,
                      onChanged: (v) {},
                      activeThumbColor: const Color(0xFF005DAC),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    indent: 70,
                    color: Color(0xFFE0E2EA),
                  ),
                  _buildSettingTile(
                    title: 'Daily Summary',
                    subtitle: 'Morning briefing at 7:00 AM',
                    icon: Icons.event_note,
                    trailing: Switch(value: false, onChanged: (v) {}),
                  ),
                ],
              ),
            ),

            // --- SEÇÃO ABOUT ---
            const SizedBox(height: 32),
            _buildSectionHeader('ABOUT'),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias, // Garante que o efeito de clique respeite o arredondamento
              child: Column(
                children: [
                  _buildAboutTile(
                    'App Version',
                    trailingText: 'v2.4.0 (Stable)',
                    icon: Icons.info_outline,
                  ),
                  const Divider(
                    height: 1,
                    indent: 70,
                    color: Color(0xFFE0E2EA),
                  ),
                  _buildAboutTile(
                    'Terms of Service',
                    icon: Icons.gavel,
                    showChevron: true,
                  ),
                  const Divider(
                    height: 1,
                    indent: 70,
                    color: Color(0xFFE0E2EA),
                  ),
                  _buildAboutTile(
                    'Credits & Acknowledgements',
                    icon: Icons.groups_outlined,
                    showChevron: true,
                  ),
                ],
              ),
            ),

            // Rodapé de Copyright
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 48.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'ATMOSPHERIC WEATHER ENGINE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        color: Colors.black26,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Refining Your Sky Since 2024',
                      style: TextStyle(fontSize: 10, color: Colors.black26),
                    ),
                  ],
                ),
              ),
            ),
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
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 4),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      options[0],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    options[1],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF414752),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSettingTile({
  required String title,
  required String subtitle,
  required IconData icon,
  required Widget trailing,
  Color? iconBgColor,
  Color? iconColor,
}) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    leading: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: iconBgColor ?? const Color(0xFF95CFFF).withValues(alpha: 0.3), // secondary-container
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: iconColor ?? const Color(0xFF005DAC), size: 20),
    ),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
    subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF414752))),
    trailing: trailing,
  );
}

Widget _buildAboutTile(String title, {IconData? icon, String? trailingText, bool showChevron = false}) {
  return ListTile(
    leading: Icon(icon, color: const Color(0xFF414752), size: 20),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (trailingText != null)
          Text(trailingText, style: const TextStyle(color: Color(0xFF414752), fontSize: 13)),
        if (showChevron)
          const Icon(Icons.chevron_right, color: Color(0xFF414752), size: 20),
      ],
    ),
    onTap: () {}, // Efeito de clique tonal-shift
  );
}