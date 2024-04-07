import 'package:big_feelings/Classes/authentication_refresh.dart';
import 'package:big_feelings/Classes/provider_setup.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Firebase/firebase_config.dart';
import 'package:big_feelings/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  setupProviders();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      title: 'Big Feelings',
      theme: themeNotifier.currentTheme.copyWith(
        textSelectionTheme: themeNotifier.textSelectionTheme,
      ),
      home: const AuthenticationWrapper(),
      onGenerateRoute: generateRoute,
      themeMode: themeNotifier.currentTheme.brightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }
}
