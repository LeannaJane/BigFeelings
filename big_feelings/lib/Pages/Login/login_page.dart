// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/* Reference
docs.flutter.dev. (n.d.). Display a snackbar. [online] Available at: https://docs.flutter.dev/cookbook/design/snackbars [Accessed 3 Feb. 2024].
The fluter website assisted me in creating a snack bar.


Reference:
Stack Overflow. (n.d.). Do not use BuildContexts across async gaps. [online] Available at: https://stackoverflow.com/questions/68871880/do-not-use-buildcontexts-across-async-gaps [Accessed 5 Feb. 2024].
This website was used to help guide me on how to handle the 'BuildContext' across async.
It told me to use the mounted property to check if the widgets are still mounted before perferming actions asynchronously.

 */

final logger = Logger();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Updated _login method to handle Firebase authentication
  Future<void> _login(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    // Attempting to sign in with email and password saved on firebase.

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // If authentication is successful
      logger.i('Logged in successfully');

      if (!mounted) return; // Check if the widget is still mounted

      // A snackbar (for now to tell the user that they have logged in successfully or failed.)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Navigate to the home page
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      logger.e('Error logging in: $e');

      if (!mounted) return; // Check if the widget is still mounted

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          // Throwing a login fail message for 2 seconds.
          content: Text('Login failed. Check your email and password.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Creating space
                const SizedBox(height: 60),
                // Add the image at the top center of the page
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    // ADDED The big feelings logo image.
                    'assets/images/children.png',
                    height: 400.0,
                    width: 400.0,
                  ),
                ),
                // Creating space
                const SizedBox(height: 16),
                // Email field.
                // Reference on how to add a icon..
                // Stack Overflow. (n.d.). Flutter Text Field: How to add Icon inside the border. [online] Available at: https://stackoverflow.com/questions/55929495/flutter-text-field-how-to-add-icon-inside-the-border [Accessed 3 Feb. 2024].
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                // Password field.
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // Changing the colors of the button.
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    // Adding padding and a font size.
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  onPressed: () => _login(context),
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
