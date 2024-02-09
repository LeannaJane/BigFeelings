import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const WelcomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'BIG FEELINGS!!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SingleDay',
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Welcome to the Big Feelings application where your child can manage and understand their feelings',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: 'SingleDay',
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Add Image widget before the Login button
            Image.asset(
              'assets/images/emotionchild.png',
              height: 300.0,
              width: 300.0,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                elevation: 5,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'SingleDay',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sign-up');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                elevation: 5,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              // Sign up text with the font family single day.
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'SingleDay',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
