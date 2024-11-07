import 'package:flutter/material.dart';
import 'package:frontend/core/style/colors.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: darkColor,
    primary: primaryColor,
    onPrimary: lightColor,
    brightness: Brightness.light,
    surface: lightColor,
    onSurface: blackColor,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontSize: 20),
    bodyLarge: TextStyle(fontSize: 30),
  ),
  useMaterial3: true,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: lightColor,
      padding: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme:
      ColorScheme.fromSeed(seedColor: darkColor, primary: primaryColor),
);
