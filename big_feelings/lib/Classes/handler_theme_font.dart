import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ThemeNotifier> loadThemeNotifier() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isDarkTheme = prefs.getBool('isDarkTheme');
  ThemeData selectedTheme =
      isDarkTheme ?? false ? ThemeNotifier.darkTheme : ThemeNotifier.lightTheme;
  return ThemeNotifier(selectedTheme);
}

Future<FontProvider> loadFontProvider() async {
  FontProvider fontProvider = FontProvider();
  await fontProvider.loadSelectedFontFamily();
  return fontProvider;
}
