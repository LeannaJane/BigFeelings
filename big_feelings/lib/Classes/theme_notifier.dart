import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  //! The first theme which is a light theme.
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.light(
      //! White background and black text and white containers.
      primary: Colors.white,
      secondary: Colors.black,
      surface: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      bodyLarge:
          TextStyle(color: Colors.black), // Updated from bodyText1 to bodyLarge
    ),
  );
  //! The second theme is for a dark theme.
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      //! Black background with white text and grey containers.
      primary: Colors.black,
      secondary: Colors.white,
      surface: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      bodyLarge:
          TextStyle(color: Colors.white), // Updated from bodyText1 to bodyLarge
    ),
  );
  late ThemeData _currentTheme;

  //! Constructor initialises ThemeNotifier with a selected theme and loads the theme preference.
  ThemeNotifier(ThemeData selectedTheme) {
    _currentTheme = selectedTheme;
    //! Load theme preference when ThemeNotifier is initialised
    _loadThemePreference();
  }

  ThemeData get currentTheme => _currentTheme;
  //! Method to set the theme and notify listeners.
  void setTheme(ThemeData newTheme) {
    _currentTheme = newTheme;
    notifyListeners();
    //! Save theme preference
    _saveThemePreference(newTheme == darkTheme);
  }

  Future<void> _loadThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDarkMode = prefs.getBool('isDarkTheme');
    if (isDarkMode != null) {
      //! Setting the theme based on choice.
      setTheme(isDarkMode ? darkTheme : lightTheme);
    } else {
      //! Default theme if preference is not set
      setTheme(lightTheme);
    }
  }

  //! Method to save the theme preference to SharedPreferences.
  Future<void> _saveThemePreference(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', isDarkMode);
  }

  Color getIconColor() {
    return _currentTheme == darkTheme ? Colors.white : Colors.black;
  }

  Color getContainerColor() {
    return _currentTheme == darkTheme ? Colors.grey[800]! : Colors.white;
  }

  Color hoverColour() {
    return _currentTheme == darkTheme
        ? const Color.fromARGB(255, 119, 118, 118)
        : Colors.white;
  }

  Color getOutlineColor() {
    return _currentTheme == darkTheme ? Colors.transparent : Colors.black;
  }

  Color cursorColor() {
    return _currentTheme == darkTheme ? Colors.white : Colors.black;
  }
}
