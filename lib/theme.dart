import 'package:flutter/material.dart';

const kColorScheme = ColorScheme(
  brightness: Brightness.light,

  //primary: Color(0xFF6200EE), // Primary color
  primary: Color(0xFF03DAC6), // Primary color
  onPrimary: Color(0xFFAFF4EE),
  secondary: Color(0xFF03DAC6), // Secondary color
  onSecondary: Colors.black,
  //background: Color(0xFFF1F1F1),
  //onBackground: Colors.black,
  surface: Colors.white,
  onSurface: Colors.black,
  error: Colors.red,
  onError: Colors.white,
);

const kDarkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFF129E0), // Primary color for dark mode
  onPrimary: Colors.black,
  secondary: Color(0xFF03DAC6),
  onSecondary: Colors.black,
  //background: Color(0xFF121212),
  //onBackground: Colors.white,
  surface: Color(0xFF1E1E1E),
  onSurface: Colors.white,
  error: Colors.red,
  onError: Colors.white,
);

// Defining the AppBarTheme in the ThemeData
final lightTheme = ThemeData.from(colorScheme: kColorScheme).copyWith(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF03DAC6), // Background color of AppBar (matches primary color)
    foregroundColor: Colors.black, // Text color on AppBar
    elevation: 4.0, // Set elevation (shadow) of AppBar
    titleTextStyle: TextStyle(
      fontSize: 20, // Title font size
      fontWeight: FontWeight.bold,
    ),
  ),
);

final darkTheme = ThemeData.from(colorScheme: kDarkColorScheme).copyWith(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFF129E0), // Background color of AppBar (matches primary color in dark mode)
    foregroundColor: Colors.white, // Text color on AppBar (white for dark mode)
    elevation: 4.0,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
);
