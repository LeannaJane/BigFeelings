//! Importing Firebase Authentication package and flutter matrial.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//! A sign Up page, that users can use to create an account, this page is pretty basic,
//! as I just wanted the Sign up button to make accounts for now, the Ui Will look nicer eventually.
//! Defining a stateful widget named SignUpPage
class SignUpPage extends StatefulWidget {
  // ignore: use_super_parameters
  const SignUpPage({Key? key}) : super(key: key);

  @override
  //!Getting state.
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

//! A class for SignUpPage
class _SignUpPageState extends State<SignUpPage> {
  final AuthService _authService = AuthService();
  //! A Controller for email input field, this allows text to be used to submit a email and password to sign up.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //! This is a variable to store error message
  String _errorText = ''; // Variable to store error message

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //! Background color set to a light baby blue like the rest of the images.
      backgroundColor: const Color.fromARGB(255, 209, 236, 238),
      appBar: AppBar(
        //! Adding a basic sign up page title in black
        title:
            const Text('Sign Up Page', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        //! Padding for all sides set to 16.0
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //! Aligning the textformfield in the center.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              //! This controller handles the email input
              controller: _emailController,
              //! It is labled email in black.
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black),
              ),
              //! Allows the user to type their email address.
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.black),
            ),
            //! This is a controller to handle the password input.
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black),
              ),
              obscureText: true,
              style: TextStyle(color: Colors.black),
            ),
            //! This displays a error message if it fails.
            const SizedBox(height: 16.0),
            Text(
              _errorText,
              style: TextStyle(color: Colors.red),
            ), // Display error message
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //! Action to be performed on button press
        //! When the user selects the button the email will be checked and the password.
        onPressed: () async {
          setState(() {
            _errorText = '';
          });

          //! This gets the email input text
          String email = _emailController.text.trim();
          //! This gets the password input text
          String password = _passwordController.text.trim();

          //! This checks if email and password are present.
          if (email.isNotEmpty && password.isNotEmpty) {
            try {
              UserCredential? userCredential =
                  await _authService.signUp(email, password);
              //! This calls the signup method
              //! This checks  if user sign-up is successful
              if (userCredential != null) {
                //! Then if it is successful a success message is prinited if not a failed message is printed.
                print('User signed up: ${userCredential.user?.email}');
              } else {
                print('Sign-up failed');
              }
              //! This catches the FirebaseAuthException
            } on FirebaseAuthException catch (e) {
              if (e.code == 'email-already-in-use') {
                //! if the error code equals email already in use a error text is printed.
                //! So that the whole error code isnt printed to the user.
                setState(() {
                  _errorText = 'Email is already in use on another account.';
                });

                //! This shows a snackbar with the error message in red.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(_errorText),
                    backgroundColor: Colors.red,
                  ),
                );
              } else {
                setState(() {
                  //! This sets error message
                  _errorText = 'Error during sign-up: ${e.message}';
                });
              }
            } catch (e) {
              print('Error during sign up: $e');
              setState(() {
                //! This prints a unexpected error message
                _errorText = 'An unexpected error occurred.';
              });
            }
          } else {
            setState(() {
              //! This prints a error message if the user only inputs one.
              _errorText = 'Please enter both email and password.';
            });
          }
        },
        //! A sign up button.
        child: const Icon(Icons.person_add, color: Colors.black),
      ),
    );
  }
}

class AuthService {
  //! Firebase authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //! Sign up with email and password method.
  Future<UserCredential?> signUp(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error during sign up: $e');
      return null;
    }
  }
}
