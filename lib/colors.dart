import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFF7931A), // Bitcoin orange
  onPrimary: Color(0xFFFFFFFF), // White for contrast text/icons
  secondary: Color(0xFF4CAF50), // Green for success actions
  onSecondary: Color(0xFFFFFFFF), // White for contrast
  surfaceContainerHighest: Color(0xFF212121), // Dark gray for text
  surface: Color(0xFFF9F9F9), // Light gray for cards or panels
  onSurface: Color(0xFF212121), // Dark gray for text
  error: Color(0xFFD32F2F), // Standard red for errors
  onError: Color(0xFFFFFFFF), // White for error text
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFF7931A), // Bitcoin orange
  onPrimary: Color(0xFF000000), // Black for contrast
  secondary: Color(0xFF81C784), // Lighter green for dark background
  onSecondary: Color(0xFF000000), // Black for contrast
  surfaceContainerHighest: Color(0xFFFFFFFF), // White for readable text
  surface: Color(0xFF1E1E1E), // Slightly lighter black
  onSurface: Color(0xFFFFFFFF), // White for readable text
  error: Color(0xFFEF5350), // Lighter red for dark mode contrast
  onError: Color(0xFF000000), // Black for error text
);

final lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  useMaterial3: true,
);

final darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  useMaterial3: true,
);