//! Inputting neccasary packages for firebase autentication and logging functionality.
// ignore_for_file: library_private_types_in_public_api, use_super_parameters

/*
! This Flutter code implements a login page with 
! Firebase authentication functionality. 
! It allows users to input their email and password for authentication, 
! with error handling for various authentication scenarios such as 
! wrong password, invalid email format, and too many login attempts. 
! The page includes UI elements for email and password input fields, 
! a login button, and a "Forgot Password?" option. 
! When the user successfully signs in they will be forwarded to the login page,
! If the user selects the forgot password method, they will be asked to type their email,
! And a new password can be made depending if their email is correct.
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

//! Logging instance
final logger = Logger();

//! Login page widget class that is used to handle the login screen UI.
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? _loginError;

  //! This is a function that handles the login authentication using firebase authentication.
  Future<void> _login(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    //! Attempting to sign in with email and password saved on firebase.

    try {
      // ignore: unused_local_variable
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //! If authentication is successful
      logger.i('Logged in successfully');

      if (!mounted) return; //! Check if the widget is still mounted

      //! A snackbar (for now to tell the user that they have logged in successfully or failed.)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      //! Navigate to the home page
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      logger.e('Error logging in: $e');

      //! Check if the widget is still mounted
      if (!mounted) return;

      //! Login error codes, checks if the errror contains any of this text, and
      //! if it does a shorter login error will be outputted to the user,
      //! as the errors from firebase are login and not as easy and simple to understand from a user perspective.
      if (e.code == 'auth/wrong-password') {
        setState(() {
          //! Wrong password.
          _loginError = 'Incorrect password. Please try again.';
        });
      } else if (e.message!.contains('too-many-requests')) {
        setState(() {
          _loginError = //! If a user tried to login too many times, they will have to reset their password to access their account.
              'Access to this account has been temporarily disabled due to many failed login attempts. Please try again later or reset your password.';
        });
      } else if (e.message!.contains('badly formatted')) {
        setState(() {
          _loginError = //! If there's no @ or if the input does not look like an email this will be outputted.
              'Invalid email format. Please check your email address.';
        });
      } else if (e.message!.contains('invalid-credential')) {
        setState(() {
          _loginError = //! Invalid email and password.
              'Invalid credentials. Please check your email and password.';
        });
      } else {
        setState(() {
          //! Then a unknown error, this will print out the full firebase error.
          //! Once this error has been found, ill handle it by adding it to this if statement.
          _loginError = 'An unknown error occurred: ${e.message}';
        });
      }
    }
  }

  //! If the user has forgot their password they can click the forget password text and they will be forwarded to the correct page.
  void _forgotPassword(BuildContext context) {
    Navigator.pushNamed(context, '/password_reset');
  }

  @override
  Widget build(BuildContext context) {
    //! These variables are used to calculate the image inside of the login page, as on mobile the image was too big, so
    //! I set that if the width of the screen is a certain size, the image will also be a certain size.
    //! Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;
    double imageScaleFactor = screenWidth < 700 ? 0.3 : 0.5;
    double imageWidth = (screenWidth * imageScaleFactor).clamp(150.0, 300.0);

    return Scaffold(
      //! Setting the background colour, and adding and customising the page title.
      backgroundColor: const Color.fromARGB(255, 209, 236, 238),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      //! Centering the title like every title, to keep consistency.
                      'BIG FEELINGS LOGIN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SingleDay',
                      ),
                    ),
                    Image.asset(
                      //! Waving penguin image.
                      'assets/images/Waving_penguin.png',
                      fit: BoxFit.cover,
                      width: imageWidth,
                    ),
                  ],
                ),
              ),
              //! Container containing login fields and button
              Container(
                width: 700,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ), // Added padding
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 8,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //! This is the email field and label
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            //! A piece of text to tell user where to enter their email.
                            'Please Enter Email',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'SingleDay',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //! Adding space between text and input.
                          const SizedBox(height: 8),
                          Container(
                            width: 600,
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 8,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            //! Email constroller to allow user to input their email with the singleday font and 16 font size.
                            child: TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                fontFamily: 'SingleDay',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 14.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //! Adding space between the two containers.
                    const SizedBox(height: 16),
                    //! This is the password field and label
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //! A piece of text that tells user where to enter their password.
                          const Text(
                            'Please Enter Password',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'SingleDay',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              width: 600,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 8,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              //! Allowing the user to input their password in the text input area within the container.
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                cursorColor: Colors.black,
                                style: const TextStyle(
                                  fontFamily: 'SingleDay',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  //! I had a padding issue, so these values may change
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 18.0, horizontal: 16.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //! A space betweeeb the container and the text.
              const SizedBox(height: 16),
              TextButton(
                //! If the user selects the forgot password they will be forwarded to the forgot password page.
                onPressed: () => _forgotPassword(context),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'SingleDay',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //! Another space betweem the login box and the forgot password.
              const SizedBox(height: 16),
              SizedBox(
                width: 150,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'SingleDay',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //! When the user selects the login button the application will try to log them in using the login function.
                    onPressed: () => _login(context),
                    child: const Text('Login'),
                  ),
                ),
              ),
              //! This will display a login message based on the error.
              if (_loginError != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    _loginError!,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
