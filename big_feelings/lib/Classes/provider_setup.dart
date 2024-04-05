import 'package:big_feelings/Classes/handler_theme_font.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void setupProviders() async {
  final fontProvider = await loadFontProvider();
  final themeNotifier = await loadThemeNotifier();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => fontProvider),
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => themeNotifier,
        ),
      ],
      child: const MyApp(),
    ),
  );
}
