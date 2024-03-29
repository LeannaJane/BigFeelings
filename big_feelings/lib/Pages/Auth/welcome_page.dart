// ignore_for_file: use_key_in_widget_constructors

import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Pages/Settings%20Page/font_dialog.dart';
import 'package:big_feelings/Pages/Settings%20Page/theme_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    //! Determine the width of the screen
    double screenWidth = MediaQuery.of(context).size.width;
    //! Declaring variables for if statement to change the height.
    double imageWidth;
    double containerWidth;
    double containerHeight;
    double buttonWidth;
    double buttonHeight;

    if (screenWidth < 400) {
      imageWidth = 350;
    } else if (screenWidth < 700) {
      imageWidth = 400;
    } else if (screenWidth < 900) {
      imageWidth = 450;
    } else if (screenWidth < 1500) {
      imageWidth = 450;
    } else {
      imageWidth = 500;
    }

    if (imageWidth == 350) {
      containerWidth = 300;
      containerHeight = 150;
      buttonWidth = 200;
      buttonHeight = 40;
    } else if (imageWidth == 400) {
      containerWidth = 400;
      containerHeight = 160;
      buttonWidth = 200;
      buttonHeight = 40;
    } else if (imageWidth == 450) {
      containerWidth = 450;
      containerHeight = 170;
      buttonWidth = 200;
      buttonHeight = 40;
    } else {
      containerWidth = 500;
      containerHeight = 180;
      buttonWidth = 200;
      buttonHeight = 40;
    }

    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        final fontProvider = Provider.of<FontProvider>(context);
        Color getContainerColor = themeNotifier.getContainerColor();

        return Scaffold(
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
                        'Big Feelings',
                        //! Editing the style as a whole instead of individually.
                        textAlign: TextAlign.center,
                        style: fontProvider.getTitleFontStyle(themeNotifier),
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
                        style: fontProvider.smalltextfontstyle(themeNotifier),
                      ),
                    ),
                    //! Image aligned in the bottom center, with a box fit cover.
                    Padding(
                      padding: const EdgeInsets.only(bottom: 80.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: imageWidth,
                              height: imageWidth,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 60.0),
                                //! Added padding only to the bottom
                                child: Image.asset(
                                  'assets/images/penguin_emotion.png',
                                  fit: BoxFit.contain,
                                  //! Changed it to a contain because the image kept cutting out.
                                ),
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
                                color: getContainerColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 8,
                                    offset: const Offset(0, -3),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              //! The login and sign up are placed in a column and centered.
                              child: Column(
                                //! Changed the elevated button to a container as looks nicer.
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: GestureDetector(
                                      onTap: () => Navigator.pushNamed(
                                          context, '/login'),
                                      child: Container(
                                        width: buttonWidth,
                                        height: buttonHeight,
                                        decoration: BoxDecoration(
                                          color: getContainerColor,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 8,
                                              offset: const Offset(0, 0),
                                            ),
                                          ],
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Login',
                                          style: fontProvider
                                              .subheadinglogin(themeNotifier),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //! Changed the elevated button to a container as looks nicer.
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: GestureDetector(
                                      onTap: () => Navigator.pushNamed(
                                          context, '/sign-up'),
                                      child: Container(
                                        width: buttonWidth,
                                        height: buttonHeight,
                                        decoration: BoxDecoration(
                                          color: getContainerColor,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 8,
                                              offset: const Offset(0, 0),
                                            ),
                                          ],
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Sign Up',
                                          style: fontProvider
                                              .subheadinglogin(themeNotifier),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //! Adding a floating button that has Tt in the center of it with the selected font family, shows the dialog that the settings page uses.
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // New floating action button on the left
                      FloatingActionButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierColor: Colors.black.withOpacity(0.85),
                            builder: (BuildContext context) {
                              return ThemeDropdownDialog(
                                fontProvider: fontProvider,
                                themeNotifier: themeNotifier,
                              );
                            },
                          );
                        },
                        //? Ref 47
                        backgroundColor: themeNotifier.getContainerColor(),
                        heroTag: 'theme_button_hero',
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: Icon(
                            themeNotifier.getThemeIcon(),
                            size: 30,
                            color: themeNotifier.getIconColor(),
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierColor: Colors.black.withOpacity(0.85),
                            builder: (context) => const FontDropdownDialog(),
                          );
                        },
                        backgroundColor: getContainerColor,
                        heroTag: 'font_button_hero',
                        child: Center(
                          child: Text(
                            'Tt',
                            style: fontProvider.buttonText(themeNotifier),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ])));
      },
    );
  }
}
