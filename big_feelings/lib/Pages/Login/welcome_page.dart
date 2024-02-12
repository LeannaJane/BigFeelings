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
    //! Determine the width of the screen
    double screenWidth = MediaQuery.of(context).size.width;
    //! Determine the scaling factor for the image based on screen width
    double imageScaleFactor = screenWidth < 700 ? 0.3 : 0.5;
    //! Calculating the width of the image
    double imageWidth = (screenWidth * imageScaleFactor).clamp(400.0, 500.0);
    //! Declaring variables for container width and height
    double containerWidth;
    double containerHeight;
    //! Setting the container size based on the image width.
    if (imageWidth == 400) {
      containerWidth = 420;
      containerHeight = 115;
    } else {
      containerWidth = 500;
      containerHeight = 145;
    }
    //! Determine button width based on image width
    double buttonWidth = imageWidth == 400 ? 150 : 200;
    //! Fixed height for buttons
    double buttonHeight = 40;

    //! Adding a button style, so that the padding and size is equal for each button
    //! I had issues where the buttons were not the same length.
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      fixedSize: Size(buttonWidth, buttonHeight),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );

    return Consumer<FontProvider>(
      builder: (context, fontProvider, _) {
        return Scaffold(
          //! Setting background colour
          backgroundColor: const Color.fromARGB(255, 209, 236, 238),
          body: SafeArea(
            //! SingleChildScrollView allows users to scroll.
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    //! Padding set to 5 for now.
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      //! Title of the application in the top center. With the assigned style from the font provider page.
                      'BIG FEELINGS',
                      textAlign: TextAlign.center,
                      //! Editing the style as a whole instead of individually.
                      style: fontProvider.getTitleFontStyle(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    //! Padding set to 5 for now.
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      //! Welcome message centered with assigned font provider and text style.
                      'Welcome to the Big Feelings application where your child can manage and understand their feelings',
                      textAlign: TextAlign.center,
                      style: fontProvider.smalltextfontstyle(),
                    ),
                  ),
                  Stack(
                    //! Image aligned in the bottom center, with a box fit cover.
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: imageWidth,
                          height: imageWidth,
                          child: Image.asset(
                            'assets/images/penguin_emotion.png',
                            fit: BoxFit
                                .contain, //! Changed it to a contain because the image kept cutting out.
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        //! A container that has the login and sign up button placed inside
                        child: Container(
                          //! Assigning width and container height variable to the container so that the container can change the size based on the screen size.
                          width: containerWidth,
                          height: containerHeight,
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
                              ElevatedButton(
                                //! Removing the elevated buttons from the sized box as this caused issues.

                                onPressed: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                style: buttonStyle,
                                child: Text(
                                  'Login',
                                  style: fontProvider.welcomepagetext(),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                //! Removing the elevated buttons from the sized box as this caused issues.

                                onPressed: () {
                                  Navigator.pushNamed(context, '/sign-up');
                                },
                                style: buttonStyle,
                                child: Text(
                                  'Sign Up',
                                  style: fontProvider.welcomepagetext(),
                                ),
                              ),
                            ],
                          ),
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
                builder: (context) => const FontDropdownDialog(),
              );
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
