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

import 'package:flutter/material.dart';
import 'login_logic.dart';

class LoginPage extends StatefulWidget {
  // ignore: use_super_parameters
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? _loginError;
  //! If the user has forgot their password they can click the forget password text and they will be forwarded to the correct page.
  void _forgotPassword(BuildContext context) {
    Navigator.pushNamed(context, '/password_reset');
  }

  @override
  Widget build(BuildContext context) {
    //! These variables are used to calculate the image inside of the login page, as on mobile the image was too big so
    //! I set tgat uf tge wudth of the screen is a certain size, the image will also be a certain size.
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
              //! A space between the container and the text.
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
                    //* Changed the On pressed to call the LoginLogic login method.
                    onPressed: () => LoginLogic.login(
                      //! Adding parameters.
                      context,
                      emailController,
                      passwordController,
                      (error) {
                        //! Adding set state here for the error, which error outputs from the login function will be set here.
                        setState(() {
                          _loginError = error;
                        });
                      },
                      //! Snackbar to show login sucessful.
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Login successful'),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      () {
                        //! Once sucessfully signed in they will go to the homepage.
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      //! This will send them to the forgot password page based on whether they forgot their password.
                      _forgotPassword,
                    ),
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
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SingleDay',
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.red,
                      decorationThickness: 4.0,
                      decorationStyle: TextDecorationStyle.solid,
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
