import 'package:flutter/material.dart';

class ThemeDefault {
  ThemeDefault._();

  /// Default Colors
  static const Color primaryColor = Color(0xff17192D);
  static const Color backgroundColor = Colors.white;
  static const Color accentColor = Color(0xff4B5FFD);
  static const Color textColor = Colors.black;

  /// AppBar Theme
  static final AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: primaryColor,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
    iconTheme: const IconThemeData(color: Colors.white),
  );

  /// Text Theme
  static final TextTheme textTheme = TextTheme(
    headlineLarge: TextStyle(color: textColor, fontSize: 32, fontWeight: FontWeight.bold),
    labelMedium: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(color: textColor, fontSize: 16),
    bodyMedium: TextStyle(fontSize: 14),
  );

  /// Color Scheme
  static final ColorScheme colorScheme = ColorScheme.light(
    primary: primaryColor,
    secondary: accentColor,
    surface: backgroundColor,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  );

  /// ThemeData principal
  static final ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: appBarTheme,
    colorScheme: colorScheme,
    textTheme: textTheme,
    iconTheme: const IconThemeData(color: primaryColor),
    buttonTheme: const ButtonThemeData(buttonColor: primaryColor, textTheme: ButtonTextTheme.primary),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: primaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
  );
}
