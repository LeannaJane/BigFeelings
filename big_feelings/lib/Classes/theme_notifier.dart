import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
      secondary: Colors.black,
      surface: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.black),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      primary: Colors.black,
      secondary: Colors.white,
      surface: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.white),
    ),
  );

  late ThemeData _currentTheme;

  ThemeNotifier(ThemeData selectedTheme) {
    _currentTheme = selectedTheme;
    _loadThemePreference(); // Load theme preference when ThemeNotifier is initialized
  }

  ThemeData get currentTheme => _currentTheme;

  void setTheme(ThemeData newTheme) {
    _currentTheme = newTheme;
    notifyListeners();
    _saveThemePreference(newTheme == darkTheme); // Save theme preference
  }

  Future<void> _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDarkMode = prefs.getBool('isDarkTheme');
    if (isDarkMode != null) {
      setTheme(isDarkMode ? darkTheme : lightTheme);
    } else {
      setTheme(lightTheme); // Default theme if preference is not set
    }
  }

  Future<void> _saveThemePreference(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDarkMode);
  }
}
