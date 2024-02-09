import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/font_size.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Pages/Breathing%20Page/breathing_page.dart';
import 'package:big_feelings/Pages/Login/login_page.dart';
import 'package:big_feelings/Pages/Login/signup_page.dart';
import 'package:big_feelings/Pages/Login/welcome_page.dart';
import 'package:big_feelings/Pages/Settings%20Page/settings_page_2.dart';
import 'package:big_feelings/Pages/home_page.dart';
import 'package:big_feelings/Pages/library_page.dart';
import 'package:big_feelings/Pages/mental_healthactivitiespage.dart';
import 'package:big_feelings/Pages/minigames_page.dart';
import 'package:big_feelings/Pages/mood_tracker_page.dart';
import 'package:big_feelings/Pages/quizzes_page.dart';

import 'package:big_feelings/Pages/yourjournal_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
This code for the adding a ChangeNotiferProvider was assited by the flutter website.
Reference:
flutterbyexample.com. (n.d.). ChangeNotifierProvider. [online] Available at: https://flutterbyexample.com/lesson/change-notifier-provider [Accessed 3 Feb. 2024].
The change notifier is a class provided by the provider package, this is used for managing and providing
instances.

In this case I used it to create and provider a instance of the Font provider class. 
This is used to change the font state, and then the changes will adapt. 
‌*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAb003siF7HEjnysZ2HKX3xoF7msO5CmNc",
      authDomain: "big-feelings-project-1234.firebaseapp.com",
      projectId: "big-feelings-project-1234",
      storageBucket: "big-feelings-project-1234.appspot.com",
      messagingSenderId: "77742859028",
      appId: "1:77742859028:web:afbfb0b229e3e915045801",
      measurementId: "G-R0H8DPSL85",
    ),
  );

  // Load the saved theme preference from shared preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isDarkTheme = prefs.getBool('isDarkTheme');

  // Set the theme based on the saved preference or use the default light theme
  ThemeData selectedTheme =
      isDarkTheme ?? false ? ThemeNotifier.darkTheme : ThemeNotifier.lightTheme;

  // Create a ThemeNotifier instance with the selected theme
  ThemeNotifier themeNotifier = ThemeNotifier(selectedTheme);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FontProvider()),
        ChangeNotifierProvider(create: (_) => FontSizeProvider()),
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => themeNotifier,
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the themeNotifier from the provider

    return MaterialApp(
      title: 'Big Feelings',
      theme: Provider.of<ThemeNotifier>(context).currentTheme,
      home: const AuthenticationWrapper(),
      onGenerateRoute: _createRoute,
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            return const WelcomePage(); //This returns to user to the welcome page once they have logged out.
          }
          return HomePage(); // If the user refreshes the page they wont instantly log out or return to the welcome page, they will stay logged in till they log themselves out.
        }
        // While determining the auth state it will show loading spinner
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

// Creating a dynamic route for the page routes, to use animations.
Route<dynamic> _createRoute(RouteSettings settings) {
  Widget page;
  switch (settings.name) {
    case '/home':
      page = HomePage();
      // This uses the back animation while the rest use the forward animation
      return _backanimation(page);
    case '/breathing':
      page = const BreathingPage();
      break;
    case '/library':
      page = const LibraryPage();
      break;
    case '/mental-health-activities':
      page = const MentalHealthActivitiesPage();
      break;
    case '/mini-games':
      page = const MiniGamesPage();
      break;
    case '/mood-tracker':
      page = const MoodTrackerPage();
      break;
    case '/quizzes':
      page = const QuizzesPage();
      break;
    case '/your-journal':
      page = const YourJournalPage();
      break;
    case '/login':
      page = const LoginPage();
      break;
    case '/sign-up':
      page = const SignUpPage();
      break;
    case '/settings-page':
      page = const SettingsPage();
      break;
    default:
      page = const WelcomePage();
  }

  return _forwardanimation(page);
}

// Page route transition animation for forward navigation
PageRouteBuilder _forwardanimation(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(
          1.0, 0.0); // This changes where the slide starts and finishes.
      var end = Offset.zero;
      var curve = Curves.easeInOutExpo; // This changes how it comes in and out.
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      // Check if it's a back navigation
      if (secondaryAnimation.status == AnimationStatus.reverse) {
        // Slide to the left for back navigation
        offsetAnimation = secondaryAnimation
            .drive(Tween(begin: const Offset(-1.0, 0.0), end: Offset.zero));
      }

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

// Page route transition animation for backward navigation
PageRouteBuilder _backanimation(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(-1.0, 0.0); // Slide from the left
      var end = Offset.zero;
      var curve = Curves.easeInExpo;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
