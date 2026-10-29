import 'package:flutter/material.dart';

class AppPalette {
  static const Color primary = Color(0xFFE96142);
  static const Color primaryDark = Color(0xFFC84C32);
  static const Color ink = Color(0xFF302923);
  static const Color muted = Color(0xFF8B8179);
  static const Color background = Color(0xFFFFF9F4);
  static const Color surface = Colors.white;
  static const Color peach = Color(0xFFFFE9DD);
  static const Color line = Color(0xFFF0E8E1);
  static const Color sage = Color(0xFFDAEADC);

  static Color fromHex(String hex) {
    final sanitized = hex.replaceAll('#', '');
    if (sanitized.length != 6) return const Color(0xFFFFD1B4);
    final parsed = int.tryParse('FF$sanitized', radix: 16);
    return Color(parsed ?? 0xFFFFD1B4);
  }
}
