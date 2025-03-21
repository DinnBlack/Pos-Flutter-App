import 'package:flutter/material.dart';

// Light Theme Colors
const lightPrimaryColor = Color(0xFF3772F0);
const lightSecondaryColor = Color(0xFFFFFFFF);
const lightBgColor = Color(0xFFF0F0F0);

// Dark Theme Colors
const darkPrimaryColor = Color(0xFF2697FF);
const darkSecondaryColor = Color(0xFF2A2D3E);
const darkBgColor = Color(0xFF212332);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: lightPrimaryColor,
  scaffoldBackgroundColor: lightBgColor,
  colorScheme: const ColorScheme.light(
    primary: lightPrimaryColor,
    secondary: lightSecondaryColor,
    background: lightBgColor,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: darkPrimaryColor,
  scaffoldBackgroundColor: darkBgColor,
  colorScheme: const ColorScheme.dark(
    primary: darkPrimaryColor,
    secondary: darkSecondaryColor,
    background: darkBgColor,
  ),
);
