import 'package:flutter/material.dart';
import 'package:atmospheric/main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface, // surface-bright
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text(
              'Personalize your weather experience',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 14),
            ),
            const SizedBox(height: 32),

            // Seções de Configuração
            _buildSectionHeader('APPEARANCE'),
            _buildSettingTile(
              context,
              title: 'Dark Mode',
              subtitle: 'Manual toggle',
              icon: Icons.dark_mode,
              trailing: ValueListenableBuilder<ThemeMode>(
                valueListenable: Main.themeNotifier,
                builder: (_, ThemeMode currentMode, __) {
                  return Switch(
                    value: currentMode == ThemeMode.dark,
                    onChanged: (v) {
                      Main.themeNotifier.value = v ? ThemeMode.dark : ThemeMode.light;
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 32),
            _buildSectionHeader('UNITS'),
            _buildUnitSelector(context, 'Temperature', [
              'Celsius (°C)',
              'Fahrenheit (°F)',
            ]),
            const SizedBox(height: 12),
            _buildUnitSelector(context, 'Distance & Wind', [
              'Metric (km/h)',
              'Imperial (mph)',
            ]),
            // --- SEÇÃO NOTIFICATIONS ---
            const SizedBox(height: 32),
            _buildSectionHeader('NOTIFICATIONS'),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildSettingTile(
                    context,
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
                  Divider(
                    height: 1,
                    indent: 70,
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  ),
                  _buildSettingTile(
                    context,
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
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias, // Garante que o efeito de clique respeite o arredondamento
              child: Column(
                children: [
                  _buildAboutTile(
                    context,
                    'App Version',
                    trailingText: 'v2.4.0 (Stable)',
                    icon: Icons.info_outline,
                  ),
                  Divider(
                    height: 1,
                    indent: 70,
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  ),
                  _buildAboutTile(
                    context,
                    'Terms of Service',
                    icon: Icons.gavel,
                    showChevron: true,
                  ),
                  Divider(
                    height: 1,
                    indent: 70,
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  ),
                  _buildAboutTile(
                    context,
                    'Credits & Acknowledgements',
                    icon: Icons.groups_outlined,
                    showChevron: true,
                  ),
                ],
              ),
            ),

            // Rodapé de Copyright
            Padding(padding: EdgeInsets.symmetric(vertical: 48.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'ATMOSPHERIC WEATHER ENGINE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.26),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Refining Your Sky Since 2024',
                      style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.26)),
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

Widget _buildUnitSelector(BuildContext context, String title, List<String> options) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainer, // surface-container-low
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
            color: Theme.of(context).colorScheme.surfaceContainerHighest, // surface-variant
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.12), blurRadius: 4),
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
                    style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant,
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

Widget _buildSettingTile(
  BuildContext context, {
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
    subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
    trailing: trailing,
  );
}

Widget _buildAboutTile(BuildContext context, String title, {IconData? icon, String? trailingText, bool showChevron = false}) {
  return ListTile(
    leading: Icon(icon, color: Theme.of(context).colorScheme.onSurfaceVariant, size: 20),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (trailingText != null)
          Text(trailingText, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 13)),
        if (showChevron)
          Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.onSurfaceVariant, size: 20),
      ],
    ),
    onTap: () {}, // Efeito de clique tonal-shift
  );
}