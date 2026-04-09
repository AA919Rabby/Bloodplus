import 'package:flutter/material.dart';

class AllThemes {
  // 1. Colors that NEVER change
  static const Color red = Color(0xFFD32F2F);
  static const Color green = Color(0xFF4CAF50);

  // 2. Simple boolean
  static bool isDarkMode = false;

  // 3. MAGIC DYNAMIC COLORS
  // CHANGED: Cards must be Dark Grey (0xFF2A2A2A) so they stand out against the black background!
  static Color get lightBg => isDarkMode ? const Color(0xFF2A2A2A) : const Color(0xFFFFFFFF);

  static Color get lightText => isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF000000);

  // Slightly lighter grey in dark mode so text is readable
  static Color get lightGrey => isDarkMode ? const Color(0xFF9E9E9E) : const Color(0xFFBDBDBD);

  // 4. Legacy constants
  static const Color darkBg = Color(0xFF121212);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkGrey = Color(0xFF424242);
}