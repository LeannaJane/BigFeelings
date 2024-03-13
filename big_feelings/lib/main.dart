import 'package:big_feelings/Classes/authentication_refresh.dart';
import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/font_size.dart';
import 'package:big_feelings/Classes/route_animations.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Pages/Journal%20Page/journal_entries.dart';
import 'package:big_feelings/Pages/Journal%20Page/view_journals.dart';
import 'package:big_feelings/Pages/Mental%20Health%20Page/mental_healthactivitiespage.dart';
import 'package:big_feelings/Pages/Mental%20health%20page/Breathing%20Page/breathing_page.dart';
import 'package:big_feelings/Pages/Journal%20Page/journal_options.dart';
import 'package:big_feelings/Pages/Login/login_ui.dart';
import 'package:big_feelings/Pages/Login/password_reset.dart';
import 'package:big_feelings/Pages/Login/signup_page.dart';
import 'package:big_feelings/Pages/Login/welcome_page.dart';
import 'package:big_feelings/Pages/Mood%20Tracker/mood_entires_page.dart';
import 'package:big_feelings/Pages/Mood%20Tracker/mood_option_page.dart';
import 'package:big_feelings/Pages/Mood%20Tracker/mood_tracker_page.dart';
import 'package:big_feelings/Pages/Quizzes/quiz_option.dart';
import 'package:big_feelings/Pages/Quizzes/quiz_page.dart';
import 'package:big_feelings/Pages/Quizzes/quizzes.dart';
import 'package:big_feelings/Pages/Settings%20Page/settings_page_2.dart';
import 'package:big_feelings/Pages/home_page.dart';
import 'package:big_feelings/Pages/library_page.dart';
import 'package:big_feelings/Pages/minigames_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
* This code for the adding a ChangeNotiferProvider was assited by the flutter website.
! Reference:
* flutterbyexample.com. (n.d.). ChangeNotifierProvider. [online] Available at: https://flutterbyexample.com/lesson/change-notifier-provider [Accessed 3 Feb. 2024].
* The change notifier is a class provided by the provider package, this is used for managing and providing
* instances.
* In this case I used it to create and provider a instance of the Font provider class. 
* This is used to change the font state, and then the changes will adapt. 
‌*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //! Initialise firebase.
  await Firebase.initializeApp(
    //! My firebase web config. Copied from firebase console s.
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

  //! Load the saved theme preference from shared preferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isDarkTheme = prefs.getBool('isDarkTheme');

  //! Set the theme based on the saved preference or use the default light theme
  ThemeData selectedTheme =
      isDarkTheme ?? false ? ThemeNotifier.darkTheme : ThemeNotifier.lightTheme;

  //! Create a ThemeNotifier instance with the selected theme
  ThemeNotifier themeNotifier = ThemeNotifier(selectedTheme);

  //! Load the selected font family
  FontProvider fontProvider = FontProvider();
  await fontProvider.loadSelectedFontFamily();

  runApp(
    MultiProvider(
      providers: [
        //! Font size provider to manage the fonts, and sizes and the theme changes.
        ChangeNotifierProvider(create: (_) => fontProvider),
        ChangeNotifierProvider(create: (_) => FontSizeProvider()),
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => themeNotifier,
        ),
      ],
      child: MyApp(),
    ),
  );
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //! Title for the Big feelings application.
      title: 'Big Feelings',
      //! Retriving the current theme.
      theme: Provider.of<ThemeNotifier>(context).currentTheme,
      //! Setting the home for the reset based on the whether there is a user logged in or not.
      //! If a user is logged in they will return to the home page when they refresh the page.
      //! If a user is not logged in they will return to the welcome page.
      home: const AuthenticationWrapper(),
      onGenerateRoute: _createRoute,
    );
  }
}

//! Creating a dynamic route for the page routes, to use animations.
Route<dynamic> _createRoute(RouteSettings settings) {
  Widget page;
  switch (settings.name) {
    case '/home':
      page = HomePage();
      return RouteAnimations.backAnimation(page);
    case '/library':
      page = const LibraryPage();
      break;
    case '/mental-health-activities':
      page = const MentalHealthActivitiesPage();
      return RouteAnimations.piggyBackingAnimation(page);
    case '/mini-games':
      page = const MiniGamesPage();
      break;
    case '/mood-tracker':
      page = const MoodTrackerPage();
      break;
    case '/quizzes':
      page = const QuizOption();
      return RouteAnimations.piggyBackingAnimation(page);
    case '/quiz-choices':
      page = const Quizzes();
      return RouteAnimations.piggyBackingAnimation(page);
    case '/quiz-one':
      page = const QuizPage1();
      return RouteAnimations.piggyBackingAnimation(page);
    case '/quiz-two':
      page = const QuizPage2();
      return RouteAnimations.piggyBackingAnimation(page);
    case '/login':
      page = const LoginPage();
      break;
    case '/sign-up':
      page = const SignUpPage();
      break;
    case '/settings-page':
      page = const SettingsPage();
      break;
    case '/password_reset':
      page = const PasswordResetPage();
      break;
    case '/journal-options':
      page = const JournalOptionPage();
      return RouteAnimations.piggyBackingAnimation(page);
    case '/mood-options':
      page = const MoodOptionPage();
      return RouteAnimations.piggyBackingAnimation(page);
    case '/journal-entries':
      page = const JournalEntriesPage();
      return RouteAnimations.piggyBackingAnimation(page);
    case '/breathing-page':
      page = const BreathingPage();
      return RouteAnimations.piggyBackingAnimation(page);
    case '/journal-viewer':
      page = const JournalViewer();
      return RouteAnimations.piggyBackingAnimation(page);
    case '/mood-entries':
      page = const MoodEntriesPage();
      return RouteAnimations.piggyBackingAnimation(page);
    case '/mood-checker':
      page = const MoodTrackerPage();
      return RouteAnimations.piggyBackingAnimation(page);
    default:
      page = const WelcomePage();
  }
  return RouteAnimations.forwardAnimation(page);
}
