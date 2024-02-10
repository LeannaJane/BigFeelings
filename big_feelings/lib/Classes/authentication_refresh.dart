import 'package:big_feelings/Pages/Login/welcome_page.dart';
import 'package:big_feelings/Pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationWrapper extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AuthenticationWrapper();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            //! This returns to user to the welcome page if the user is not logged in and the page refreshes.
            return const WelcomePage();
          }
          //! If the user refreshes the page they wont instantly log out or return to the welcome page, they will stay logged in till they log themselves out.
          return HomePage();
        }
        //! While determining the auth state it will show loading spinner
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
