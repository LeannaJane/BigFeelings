import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

//! Logging instance
final logger = Logger();

class LoginLogic {
  static void login(
    //! Getting access to the neccassary functions and to the text enetered.
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    Function(String) setLoginError,
    Function() showSnackBar,
    Function() navigateToHome,
    Function(BuildContext) forgotPassword,
  ) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      //! If authentication is successful
      logger.i('Logged in successfully');
      //! A snackbar (for now to tell the user that they have logged in successfully or failed.)
      showSnackBar();
      //! Navigate to the home page
      navigateToHome();
      //? Ref 8
    } on FirebaseAuthException catch (e) {
      logger.e('Error logging in: $e');
      //! This code block catches the error from firebase e. Then $e is used to convert its value
      //! into a log message.
      if (e.code == 'auth/wrong-password') {
        setLoginError('Incorrect password. Please try again.');
        //! If a user tried to login too many times, they will have to reset their password to access their account.
      } else if (e.message!.contains('too-many-requests')) {
        setLoginError(
            'Access to this account has been temporarily disabled due to many failed login attempts. Please try again later or reset your password.');
        //! If there's no @ or if the input does not look like an email this will be outputted.
      } else if (e.message!.contains('badly formatted')) {
        setLoginError('Invalid email format. Please check your email address.');
        //! Invalid email and password.
      } else if (e.message!.contains('invalid-credential')) {
        setLoginError(
            'Invalid credentials. Please check your email and password.');
        //! Then a unknown error, this will print out the full firebase error.
        //! Once this error has been found, ill handle it by adding it to this if statement.
      } else {
        setLoginError('An unknown error occurred: ${e.message}');
      }
    }
  }
}
