import 'package:flutter/material.dart';

class AppColors {
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color primary(BuildContext context) => isDark(context) ? Colors.lightBlue : Colors.blueAccent;
  static Color surface(BuildContext context) => isDark(context) ? const Color(0xFF121212) : Colors.white;
  static Color surfaceContainer(BuildContext context) => isDark(context) ? const Color(0xFF1E1E1E) : Theme.of(context).colorScheme.surfaceContainer;
  static Color surfaceContainerHigh(BuildContext context) => isDark(context) ? const Color(0xFF2C2C2C) : Theme.of(context).colorScheme.surfaceContainerHighest;
  static Color surfaceContainerHighest(BuildContext context) => isDark(context) ? const Color(0xFF383838) : Theme.of(context).colorScheme.surfaceContainerHighest;
  
  static Color textPrimary(BuildContext context) => isDark(context) ? Colors.white : Theme.of(context).colorScheme.onSurface;
  static Color textSecondary(BuildContext context) => isDark(context) ? Colors.white70 : Theme.of(context).colorScheme.onSurfaceVariant;
  static Color textTertiary(BuildContext context) => isDark(context) ? Colors.white38 : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.26);
  
  static Color divider(BuildContext context) => isDark(context) ? Colors.white12 : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.12);
  static Color navbarBg(BuildContext context) => isDark(context) ? const Color(0xFF121212).withValues(alpha: 0.9) : Colors.white.withValues(alpha: 0.9);
}
