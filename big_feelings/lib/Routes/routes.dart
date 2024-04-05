import 'package:big_feelings/Routes/page_imports.dart';
import 'package:flutter/material.dart';
import 'package:big_feelings/Classes/route_animations.dart';

//! Creating a dynamic route for the page routes, to use animations.
Route<dynamic> generateRoute(RouteSettings settings) {
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
    case '/signup-desktop':
      page = const Signupdesktop();
      return RouteAnimations.instantAnimation(page);
    case '/signup-mobile':
      page = const SignupMobile();
      return RouteAnimations.instantAnimation(page);
    case '/settings-page':
      page = const SettingsPage();
      return RouteAnimations.piggyBackingAnimation(page);
    case '/reset-desktop':
      page = const PasswordResetDesktop();
      return RouteAnimations.instantAnimation(page);
    case '/reset-mobile':
      page = const PasswordResetMobile();
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
    case '/tutorial':
      page = const Tutorial();
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
