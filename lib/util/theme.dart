import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  late bool isDarkMode;
  get darkTheme => _darkTheme;
  get lightTheme => _lightTheme;
  get currentTheme => _currentTheme;

  ThemeData? _currentTheme;

  ThemeNotifier({this.isDarkMode = true}) {
    _currentTheme = _darkTheme;
  }

  final _darkTheme = ThemeData(
    colorScheme: const ColorScheme(
      primary: Colors.black54,
      secondary: Colors.amber,
      background: Colors.black,
      brightness: Brightness.dark,
      error: Colors.red,
      onBackground: Colors.orange,
      onError: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.white,
    ),
    brightness: Brightness.dark,
    dividerTheme: const DividerThemeData(
      thickness: 1,
      color: Colors.white,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionHandleColor: Colors.orange,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.grey,
      ),
      focusColor: Colors.black,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.orange,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Colors.amberAccent,
        ),
      ),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headline2: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headline3: TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
      bodyText1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyText2: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    ),
  );

  final _lightTheme = ThemeData(
    colorScheme: const ColorScheme(
      primary: Colors.black54,
      secondary: Colors.amber,
      background: Colors.white,
      brightness: Brightness.light,
      error: Colors.red,
      onBackground: Colors.orange,
      onError: Colors.black,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      surface: Colors.black,
      onSurface: Colors.black,
    ),
    brightness: Brightness.light,
    dividerTheme: const DividerThemeData(
      thickness: 1,
      color: Colors.black,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionHandleColor: Colors.orange,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.grey,
      ),
      focusColor: Colors.black,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.orange,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Colors.amberAccent,
        ),
      ),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headline2: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headline3: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      bodyText1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: Colors.black,
      ),
    ),
    backgroundColor: Colors.white,
  );

  void switchThemeMode() {
    isDarkMode = !isDarkMode;
    _currentTheme = isDarkMode ? _darkTheme : _lightTheme;

    notifyListeners();
  }
}
