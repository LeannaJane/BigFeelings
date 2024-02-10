import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const WelcomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //! Setting background colour
      backgroundColor: const Color.fromARGB(255, 209, 236, 238),
      body: SafeArea(
        //! SingleChildScrollView allows users to scroll.
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  //! Padding set to 5 for now.
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    //! Title of the application in the top center. Default font family, font weight set to bold and 50 size font.
                    'BIG FEELINGS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SingleDay',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const Padding(
                //! Padding set to 5 for now.
                padding: EdgeInsets.all(5.0),
                child: Text(
                  //! Welcome message centered, with the default font and message size set to 22.
                  'Welcome to the Big Feelings application where your child can manage and understand their feelings',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontFamily: 'SingleDay',
                  ),
                ),
              ),
              Stack(
                //! Image aligned in the bottom center, with a box fit cover.
                alignment: Alignment.bottomCenter,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/penguin_emotion.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  //! A container that has the login and sign up button placed inside
                  Container(
                    //! Width of the container set to 500 with 20 symetric padding and the colour set to white with a shadow.
                    width: 500,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 8,
                          offset: const Offset(0, -3),
                        ),
                      ],
                      //! The corners of the box set to a 30 radius.
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    //! The login and sign up are placed in a column and centered.
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          //! Width and height of the sized boxes equal the same.
                          width: 150,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              //! Navigation to the login page.
                              Navigator.pushNamed(context, '/login');
                            },
                            //! The background of the button set to black and text set to white.
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Text(
                              //! The login text in the center of the sized box with a 20 font sized and the font family has been set.
                              'Login',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'SingleDay',
                              ),
                            ),
                          ),
                        ),
                        //! A sized box to create space between the login and signup button.
                        const SizedBox(height: 20),
                        SizedBox(
                          //! Width and height set
                          width: 150,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              //! Once selected the user will be forwarded to the signup route page.
                              Navigator.pushNamed(context, '/sign-up');
                            },
                            style: ElevatedButton.styleFrom(
                              //! Colours set to match both buttons.
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            //! Sign up text centered in the size box with the same font and size.
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'SingleDay',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
