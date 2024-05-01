//! Logging instance
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class LoginLogic {
  static void login(
    //! Getting access to the necessary functions and to the text entered.
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    Function(String) setLoginError,
    Function() showSnackBar,
    //! Changed it to string as the UID is a string.
    Function(String) navigateToHome,
    Function(BuildContext) forgotPassword,
  ) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setLoginError('Please type both email and password.');
      return;
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      //! If the user authentication is successful
      User? user = userCredential.user;
      if (user != null) {
        //! Checks if email is verified
        if (!user.emailVerified) {
          setLoginError(
              'Email is not verified. Please verify your email. Check your spam/junk folder.');
          return;
        }
        //! This gets the user id.
        String userId = user.uid;
        //! This prints user logged in and userID to the terminal.
        logger.i('User logged in successfully. UserID: $userId');

        //! Clear texts from text controllers
        emailController.clear();
        passwordController.clear();

        //! Navigate to the home page
        navigateToHome(userId);
      }
      //? Ref 8
    } on FirebaseAuthException catch (e) {
      logger.e(
          'FirebaseAuthException caught: Code: ${e.code}, Message: ${e.message}');

      if (e.code == 'wrong-password') {
        setLoginError('Incorrect password. Please try again.');
      } else if (e.message != null && e.message!.contains('badly formatted')) {
        setLoginError('Invalid email format. Please check your email address.');
      } else if (e.message != null &&
          e.message!.contains('invalid-credential')) {
        setLoginError(
            'Invalid credentials. Please check your email and password.');
      } else if (e.message != null && e.message!.contains('malformed')) {
        setLoginError(
            'Invalid credentials. Please check your email and password.');
      } else if (e.code == 'too-many-requests') {
        setLoginError(
            'Account temporarily locked due to too many failed login attempts. Reset your password or try again later.');
      } else {
        setLoginError(
            'An error occurred during login. Please try again later.');
      }
    }
  }
}
