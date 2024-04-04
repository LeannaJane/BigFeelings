import 'package:big_feelings/Classes/authentication_refresh.dart';
import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/route_animations.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Pages/Auth/Login/login_desktop.dart';
import 'package:big_feelings/Pages/Auth/Login/login_mobile.dart';
import 'package:big_feelings/Pages/Auth/Sign%20up/signup_ui.dart';
import 'package:big_feelings/Pages/Auth/password_reset.dart';
import 'package:big_feelings/Pages/Auth/welcome_page.dart';
import 'package:big_feelings/Pages/Journal%20Page/journal_entries.dart';
import 'package:big_feelings/Pages/Journal%20Page/view_journals.dart';
import 'package:big_feelings/Pages/Library%20Page/Educational%20Videos/video_option_page.dart';
import 'package:big_feelings/Pages/Library%20Page/Getting%20Help/coping_methods.dart';
import 'package:big_feelings/Pages/Library%20Page/library_page.dart';
import 'package:big_feelings/Pages/Mental%20Health%20Page/mental_healthactivitiespage.dart';
import 'package:big_feelings/Pages/Mental%20health%20page/Breathing%20Page/breathing_page.dart';
import 'package:big_feelings/Pages/Journal%20Page/journal_options.dart';
import 'package:big_feelings/Pages/Minigames%20Page/Memory%20card%20game/Logic/gameboard.dart';
import 'package:big_feelings/Pages/Minigames%20Page/Memory%20card%20game/Logic/mobile_ui.dart';
import 'package:big_feelings/Pages/Minigames%20Page/Memory%20card%20game/UI/start_game.dart';
import 'package:big_feelings/Pages/Mood%20Tracker/mood_entires_page.dart';
import 'package:big_feelings/Pages/Mood%20Tracker/mood_option_page.dart';
import 'package:big_feelings/Pages/Mood%20Tracker/mood_tracker_page.dart';
import 'package:big_feelings/Pages/Quizzes/Submit%20quiz/quiz_one.dart';
import 'package:big_feelings/Pages/Quizzes/Submit%20quiz/quiz_one_option.dart';
import 'package:big_feelings/Pages/Quizzes/View%20Quiz%20results/view_quiz_results.dart';
import 'package:big_feelings/Pages/Quizzes/quiz_option.dart';
import 'package:big_feelings/Pages/Quizzes/Submit%20quiz/quiz_page.dart';
import 'package:big_feelings/Pages/Quizzes/Submit%20quiz/quiz_two.dart';
import 'package:big_feelings/Pages/Quizzes/Submit%20quiz/quiz_two_option.dart';
import 'package:big_feelings/Pages/Settings%20Page/delete_buffer.dart';
import 'package:big_feelings/Pages/Settings%20Page/settings_page_2.dart';
import 'package:big_feelings/Pages/home_page.dart';
import 'package:big_feelings/Pages/Minigames%20Page/MIni_game_option_page.dart/minigames_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//? Ref 37

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
    final themeNotifier = Provider.of<ThemeNotifier>(context);

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
      themeMode: themeNotifier.currentTheme.brightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
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
      return RouteAnimations.piggyBackingAnimation(page);
    case '/mental-health-activities':
      page = const MentalHealthActivitiesPage();
      return RouteAnimations.piggyBackingAnimation(page);
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
    case '/quiz-one-page':
      page = const StartQuiz1();
      return RouteAnimations.instantAnimation(page);
    case '/quiz-two':
      page = const QuizPage2();
      return RouteAnimations.piggyBackingAnimation(page);
    case '/quiz-two-page':
      page = const StartQuiz2();
      return RouteAnimations.instantAnimation(page);
    case '/quiz-results':
      page = QuizResults();
      return RouteAnimations.piggyBackingAnimation(page);
    case '/login-desktop':
      page = const LoginPageDesktop();
      return RouteAnimations.instantAnimation(page);
    case '/login-mobile':
      page = const LoginMobilePage();
      return RouteAnimations.instantAnimation(page);
    case '/sign-up':
      page = const SignUpPage();
      return RouteAnimations.instantAnimation(page);
    case '/settings-page':
      page = const SettingsPage();
      break;
    case '/password_reset':
      page = const PasswordResetPage();
      return RouteAnimations.instantAnimation(page);
    case '/mini-game-options':
      page = const MiniGamesPage();
      return RouteAnimations.piggyBackingAnimation(page);
    case '/memory-game-options':
      page = const StartGame();
      return RouteAnimations.piggyBackingAnimation(page);
    case '/memory-game-desktop':
      final Color selectedColor = settings.arguments as Color;
      page = GameBoard(color: selectedColor);
      return RouteAnimations.piggyBackingAnimation(page);
    case '/memory-mobile':
      final Color selectedColor = settings.arguments as Color;
      page = GameBoardMobile(color: selectedColor);
      return RouteAnimations.piggyBackingAnimation(page);
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
      page = MoodEntriesPage();
      return RouteAnimations.piggyBackingAnimation(page);
    case '/mood-checker':
      page = const MoodTrackerPage();
      return RouteAnimations.piggyBackingAnimation(page);
    case '/video-options':
      page = const VideoOptions();
      return RouteAnimations.piggyBackingAnimation(page);
    case '/coping-methods':
      page = const CopingMethods();
      return RouteAnimations.piggyBackingAnimation(page);
    case '/delete':
      page = DeletingBufferingPage();
      return RouteAnimations.instantAnimation(page);
    default:
      page = const WelcomePage();
      return RouteAnimations.piggyBackingAnimation(page);
  }
  return RouteAnimations.forwardAnimation(page);
}
