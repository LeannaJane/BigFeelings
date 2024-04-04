import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

//! This class fetches the quiz data from firestore based on the quizId
class QuizFetcher {
  static final Logger _logger = Logger();
  static Future<List<Map<String, dynamic>>> fetchQuizData(String quizId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      //! Retrieves the quiz document from Firestore
      DocumentSnapshot quizSnapshot =
          await firestore.collection('QuizCollection').doc(quizId).get();

      if (!quizSnapshot.exists) {
        throw Exception('Quiz document does not exist');
      }
      //! This extracts the data from the quiz document
      Map<String, dynamic>? data = quizSnapshot.data() as Map<String, dynamic>?;

      if (data == null) {
        throw Exception('Quiz data is null');
      }
      //! This line parses the data and format it into a list of maps containing questions, options, and answers

      List<Map<String, dynamic>> quizData = [];

      for (int i = 1; i <= 10; i++) {
        String questionKey = 'Q${i}_question';
        String optionsKey = 'Q${i}_options';
        String answerKey = 'Q${i}_answer';
        //! This gets the question, options, and answer from data and formats them

        String question =
            data[questionKey]?.toString().replaceAll('"', '') ?? '';
        List<String> options = [];
        dynamic optionsData = data[optionsKey];

        if (optionsData != null && optionsData is Iterable) {
          options = List<String>.from(optionsData)
              .map((option) => option.toString().replaceAll('"', ''))
              .toList();
        }
        String answer = data[answerKey]?.toString().replaceAll('"', '') ?? '';

        //! Add question, options, and answer to the quiz data list
        quizData.add({
          'question': question,
          'options': options,
          'answer': answer,
        });
      }
      //! This returns the formatted quiz data
      return quizData;
    } catch (error, stackTrace) {
      //! This logs any errors that occur during fetching
      _logger.e('Error fetching quiz data',
          error: error, stackTrace: stackTrace);
      return [];
    }
  }
}

class QuizSubmitter {
  static final Logger _logger = Logger();

  static Future<bool> submitQuiz(
    String quizId,
    List<String?> userAnswers,
    BuildContext context, // Added BuildContext parameter
    List<Map<String, dynamic>> quizData,
    FontProvider fontProvider,
    ThemeNotifier themeNotifier,
  ) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final User? user = FirebaseAuth.instance.currentUser;

      int score = 0;

      if (userAnswers.length != quizData.length) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text(
                'Please answer all questions before submitting.',
                textAlign: TextAlign.center,
                style: fontProvider.subheadingBig(themeNotifier),
              ),
            ),
            backgroundColor:
                themeNotifier.currentTheme == ThemeNotifier.lightTheme
                    ? Colors.red
                    : Colors.red.shade800,
          ),
        );
        return false;
      }

      for (int i = 0; i < userAnswers.length; i++) {
        String? userAnswer = userAnswers[i];
        String correctAnswer = quizData[i]['answer'];

        if (userAnswer == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  'Please answer all questions before submitting.',
                  textAlign: TextAlign.center,
                  style: fontProvider.subheadingBig(themeNotifier),
                ),
              ),
              backgroundColor:
                  themeNotifier.currentTheme == ThemeNotifier.lightTheme
                      ? Colors.red
                      : Colors.red.shade800,
            ),
          );
          return false;
        }

        if (userAnswer == correctAnswer) {
          score++;
        }
      }

      await firestore.collection('QuizCollectionResults').add({
        'quizId': quizId,
        'score': score,
        'user': user?.uid,
        'timestamp': Timestamp.now(),
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              'Quiz saved successfully.',
              textAlign: TextAlign.center,
              style: fontProvider.subheadingBig(themeNotifier),
            ),
          ),
          backgroundColor:
              themeNotifier.currentTheme == ThemeNotifier.lightTheme
                  ? Colors.green
                  : Colors.green.shade800,
        ),
      );
      return true;
    } catch (error, stackTrace) {
      _logger.e('Error submitting quiz', error: error, stackTrace: stackTrace);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              'Failed to submit quiz. Please try again later.',
              style: fontProvider.subheadingBig(themeNotifier),
            ),
          ),
          backgroundColor: themeNotifier.currentTheme ==
                  ThemeNotifier.lightTheme
              ? Colors.red // Set red background color for light theme
              : Colors.red.shade800, // Set red background color for dark theme
        ),
      );
      return false;
    }
  }
}
