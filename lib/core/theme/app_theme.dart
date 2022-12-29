import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static Color _iconColor = Colors.white24;
  static const Color _lightPrimaryColor = Color.fromARGB(255, 5, 105, 151);
  static const Color _lightPrimaryVariantColor = Color(0xFF33678A);
  static const Color _lightSecondaryColor = Colors.white24;
  static const Color _lightOnPrimaryColor = Color(0XFFEAEFF3);

  static const Color _darkPrimaryColor = Colors.white24;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static const Color _darkSecondaryColor = Colors.white;
  static const Color _darkOnPrimaryColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: "Merriweather",
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      color: _lightPrimaryColor,
      iconTheme: IconThemeData(color: _lightOnPrimaryColor),
    ),
    colorScheme: const ColorScheme.light(
      primary: _lightPrimaryColor,
      secondary: _lightSecondaryColor,
      onPrimary: _lightOnPrimaryColor,
      onSecondary: _lightPrimaryVariantColor,
    ),
    iconTheme: IconThemeData(
      color: _iconColor,
    ),
    textTheme: _lightTextTheme,
    scaffoldBackgroundColor: _lightOnPrimaryColor,
    dividerTheme: const DividerThemeData(
      color: Colors.black12,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: _darkPrimaryVariantColor,
      appBarTheme: const AppBarTheme(
        color: _darkPrimaryVariantColor,
        iconTheme: IconThemeData(color: _darkOnPrimaryColor),
      ),
      colorScheme: const ColorScheme.dark(
        primary: _darkPrimaryColor,
        secondary: _darkSecondaryColor,
        onPrimary: _darkOnPrimaryColor,
        background: Colors.white12,
      ),
      iconTheme: IconThemeData(
        color: _iconColor,
      ),
      textTheme: _darkTextTheme,
      dividerTheme: const DividerThemeData(color: Colors.black));

  static const TextTheme _lightTextTheme = TextTheme(
    headline1: _lightScreenHeading1TextStyle,
    bodyText1: _lightScreenBody1TextStyle,
  );

  static final TextTheme _darkTextTheme = TextTheme(
    headline1: _darkScreenHeading1TextStyle,
  );

  static const TextStyle _lightScreenHeading1TextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: _lightPrimaryColor,
    fontFamily: "Merriweather",
  );
  static const TextStyle _lightScreenBody1TextStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w300,
    color: Colors.black,
    fontFamily: "Merriweather",
  );
  static final TextStyle _darkScreenHeading1TextStyle =
      _lightScreenHeading1TextStyle.copyWith(
    color: _darkOnPrimaryColor,
  );
}
