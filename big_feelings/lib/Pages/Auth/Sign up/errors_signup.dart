import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';

class SignUpLogic {
  static Future<void> signup(
    String email,
    String password,
    Function(String) onError,
    BuildContext context,
    FontProvider fontProvider,
    ThemeNotifier themeNotifier,
  ) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        onError('Please enter both email and password.');
        return;
      }

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Reset authentication state to not signed in as I dont want to automatically sign in users.
      await FirebaseAuth.instance.signOut();

      if (userCredential.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Sign up successful',
              style: fontProvider.subheadinglogin(themeNotifier),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        onError('Sign-up failed');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        onError('Email is already in use on another account.');
      } else {
        onError('Error during sign-up: ${e.message}');
      }
    } catch (e) {
      onError('An unexpected error occurred.');
    }
  }
}
