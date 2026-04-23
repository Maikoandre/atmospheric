import 'package:atmospheric/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(Main());
}

class Main extends StatefulWidget {
  const Main({super.key});
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
  static final ValueNotifier<bool> isCelsiusNotifier = ValueNotifier(true);
  static final ValueNotifier<bool> isMetricNotifier = ValueNotifier(true);

  static String formatTemp(double tempCelsius) {
    if (isCelsiusNotifier.value) {
      return '${tempCelsius.round()}°';
    } else {
      return '${((tempCelsius * 9 / 5) + 32).round()}°';
    }
  }

  static String formatWindSpeed(double speed) {
    if (isMetricNotifier.value) {
      return '${speed.round()} km/h';
    } else {
      return '${(speed * 0.621371).round()} mph';
    }
  }

  static String formatVisibility(int visibilityMeters) {
    if (isMetricNotifier.value) {
      return '${(visibilityMeters / 1000).toStringAsFixed(0)} km';
    } else {
      return '${(visibilityMeters / 1000 * 0.621371).toStringAsFixed(0)} mi';
    }
  }

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: Main.themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return ValueListenableBuilder<bool>(
          valueListenable: Main.isCelsiusNotifier,
          builder: (_, bool isCelsius, __) {
            return ValueListenableBuilder<bool>(
              valueListenable: Main.isMetricNotifier,
              builder: (_, bool isMetric, __) {
                return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                brightness: Brightness.light,
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent, brightness: Brightness.light),
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent, brightness: Brightness.dark),
              ),
              themeMode: currentMode,
              builder: (context, child) {
                return ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(
                    overscroll: false, // Desativa o efeito de overscroll
                    scrollbars: false, // Desativa as barras de rolagem
                  ),
                  child: child!,
                );
              },
              home: HomePage(),
            );
          },
        );
      },
    );
  },
);
  }
}