import 'package:flutter/material.dart';

import 'design_tokens.dart';

abstract final class NexoTheme {
  static ThemeData get light => _build(
        Brightness.light,
        const Color(0xFFF7F7F4),
        Colors.white,
        const Color(0xFF526F5B),
      );

  static ThemeData get dark => _build(
        Brightness.dark,
        const Color(0xFF111310),
        const Color(0xFF1B1E1A),
        const Color(0xFF8CB398),
      );

  static ThemeData _build(
    Brightness brightness,
    Color background,
    Color surface,
    Color primary,
  ) {
    final scheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: brightness,
      surface: surface,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(NexoRadii.card),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        elevation: 0,
        indicatorColor: scheme.primaryContainer,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: surface,
        indicatorColor: scheme.primaryContainer,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(NexoRadii.floatingButton),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(NexoRadii.control),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
