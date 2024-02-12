import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Pages/Settings%20Page/font_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//! Removing const values, and applying the fontprovider selected family for all the text and creating a font changing button.
class WelcomePage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const WelcomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FontProvider>(
      builder: (context, fontProvider, _) {
        final selectedFontFamily = fontProvider.selectedFontFamily;
        return Scaffold(
          //! Setting background colour
          backgroundColor: const Color.fromARGB(255, 209, 236, 238),
          body: SafeArea(
            //! SingleChildScrollView allows users to scroll.
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      //! Padding set to 5 for now.
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        //! Title of the application in the top center. Default font family, font weight set to bold and 50 size font.
                        'BIG FEELINGS',
                        textAlign: TextAlign.center,
                        //! Editing the style as a whole instead of individually.
                        style: fontProvider.getTitleFontStyle(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    //! Padding set to 5 for now.
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      //! Welcome message centered, with the default font and message size set to 22.
                      'Welcome to the Big Feelings application where your child can manage and understand their feelings',
                      textAlign: TextAlign.center,
                      style: fontProvider.smalltextfontstyle(),
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
                        width: 400,
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
                                child: Text(
                                  //! The login text in the center of the sized box with a 20 font sized and the font family has been set.
                                  'Login',
                                  style: fontProvider.smalltextfontstyle(),
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
                                child: Text(
                                  'Sign Up',
                                  style: fontProvider.smalltextfontstyle(),
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
          //! Adding a floating button that has Tt in the center of it with the selected font family, shows the dialog that the settings page uses.
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Show font selection dialog or bottom sheet
              showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.85),
                  builder: (context) => const FontDropdownDialog());
            },
            //! Set background color to white of the button.
            backgroundColor: Colors.black,
            child: Center(
              child: Text(
                //! Setting the letters as Tt, making it bald, black and the selected font family to keep consistency across the application.
                'Tt',
                style: fontProvider.smalltextfontstyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
