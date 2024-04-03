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
  //! Submits the quiz results to Firestore
  static Future<bool> submitQuiz(
    String quizId,
    List<String?> userAnswers,
    void Function(String message, Color color) showMessage,
    List<Map<String, dynamic>> quizData,
  ) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      final User? user = FirebaseAuth.instance.currentUser;

      int score = 0;
      //! Check if the number of user answers matches the number of quiz questions
      //! If not it will show a error message telling the user to answer all questions.
      if (userAnswers.length != quizData.length) {
        showMessage(
          'Please answer all questions before submitting.',
          Colors.red,
        );
        return false;
      }
      //! Calculate the score based on user answers
      for (int i = 0; i < userAnswers.length; i++) {
        String? userAnswer = userAnswers[i];
        String correctAnswer = quizData[i]['answer'];

        if (userAnswer == null) {
          showMessage(
              'Please answer all questions before submitting.', Colors.red);
          return false;
        }

        if (userAnswer == correctAnswer) {
          score++;
        }
      }
      //! Saves the user, quizid, score and time to firestore.
      await firestore.collection('QuizCollectionResults').add({
        'quizId': quizId,
        'score': score,
        'user': user?.uid,
        'timestamp': Timestamp.now(),
      });
      //! Message to tell user quiz has been saved.
      showMessage('Quiz submitted successfully!', Colors.green);
      return true;
      //! Error message to tell user it failed.
    } catch (error, stackTrace) {
      _logger.e('Error submitting quiz', error: error, stackTrace: stackTrace);
      showMessage('Failed to submit quiz. Please try again later.', Colors.red);
      return false;
    }
  }
}
