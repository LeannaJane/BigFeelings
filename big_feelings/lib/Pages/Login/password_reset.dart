import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

//! A statement widget
class PasswordResetPage extends StatefulWidget {
  // ignore: use_super_parameters
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

//! A password reset class that allows the user to reset their password by entering their email, and if their emails correct and a real email a reset email will be sent.
class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController emailController = TextEditingController();
  //! A flag for email sent.
  bool _emailSent = false;

  //! Method to send password reset email
  void _sendPasswordResetEmail(BuildContext context) async {
    String email = emailController.text.trim();

    try {
      //! Sends password reset with firebase auth. If successsful a success message will be printed.
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      //! If password reset email sent successfully
      logger.i('Password reset email sent successfully');

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          //! A snackbar message to tell user that a email has been sent.
          content: Text('Password reset email sent successfully'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      //! If email sent is true it sets the state.
      setState(() {
        _emailSent = true;
      });
      //! Catches error, and outputs it in a snackbar for 2 seconds.
    } catch (e) {
      logger.e('Error sending password reset email: $e');

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error sending password reset email'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //! Reset password title.
        title: const Text('Reset Password'),
      ),
      body: Padding(
        //! 16 padding.
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              //! A message to ask user to enter their email. This is aligned in the center with a font size and font boldness set.
              'Please Enter Your Email to Reset Password',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            //! A sized box to make space between the email message and the input email.
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            //! A sized box to make space between the email input and send button.
            const SizedBox(height: 20),
            //! A button used to send the resetpassword email in red.
            ElevatedButton(
              onPressed: () => _sendPasswordResetEmail(context),
              child: const Text(
                'Send Reset Email',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            //! If statement to output a message if the email has been sent.
            if (_emailSent)
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  //! When a correct email is inputted the user will recieve this message on their screen. When a password reset email has been set.
                  'An email has been sent to reset your password.',
                  style: TextStyle(
                    //! The colour is set to green for now.
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
