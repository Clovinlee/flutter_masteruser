import 'package:c_masteruser/themes/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:material_color_generator/material_color_generator.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: "Lexend",
  primarySwatch: generateMaterialColor(color: ThemeManager.primaryColor),
  primaryColor: ThemeManager.primaryColor,
  secondaryHeaderColor: ThemeManager.secondaryColor,
  // canvasColor: Color.fromARGB(255, 243, 222, 174),
  textTheme: TextTheme(
    // 2021 Style
    // displayLarge, displayMedium, displaySmall
    // headlineLarge, headlineMedium, headlineSmall
    // titleLarge, titleMedium, titleSmall
    // bodyLarge, bodyMedium, bodySmall
    // labelLarge, labelMedium, labelSmall

    displayLarge: TextStyle(fontSize: 40),
    displayMedium: TextStyle(fontSize: 36),
    displaySmall: TextStyle(fontSize: 32),
    headlineLarge: TextStyle(fontSize: 28),
    headlineMedium: TextStyle(fontSize: 24),
    headlineSmall: TextStyle(fontSize: 20),
    bodyLarge: TextStyle(fontSize: 18),
    bodyMedium: TextStyle(fontSize: 16),
    bodySmall: TextStyle(fontSize: 14),
    labelLarge: TextStyle(fontSize: 12),
    labelMedium: TextStyle(fontSize: 10),
    labelSmall: TextStyle(fontSize: 8),
  ).apply(
    bodyColor: ThemeManager.textColor,
    displayColor: ThemeManager.textColor,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
);
