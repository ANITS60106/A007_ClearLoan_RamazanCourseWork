import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    const green = Color(0xFF1DB954);
    const red = Color(0xFFE53935);
    const bg = Color(0xFF0F1115);

    final colorScheme = ColorScheme.fromSeed(
      seedColor: green,
      brightness: Brightness.dark,
      primary: green,
      secondary: red,
      surface: const Color(0xFF171A21),
      background: bg,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: bg,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        color: const Color(0xFF171A21),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF171A21),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: Colors.white54),
        labelStyle: const TextStyle(color: Colors.white70),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF171A21),
        selectedColor: green.withOpacity(0.18),
        labelStyle: const TextStyle(color: Colors.white70),
        secondaryLabelStyle: const TextStyle(color: Colors.white),
        side: const BorderSide(color: Colors.white12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
      dividerColor: Colors.white12,
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontWeight: FontWeight.w700),
        titleMedium: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
