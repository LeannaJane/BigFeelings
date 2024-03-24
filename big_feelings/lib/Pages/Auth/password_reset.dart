// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Pages/Settings%20Page/font_dialog.dart';
import 'package:big_feelings/Pages/Settings%20Page/theme_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

//! A password reset class, that resets the password and presents the UI.
//! This class contains a bool that checks whether an email has been sent, to output the right information to the user.
class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController emailController = TextEditingController();
  bool? _emailSent;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_clearError);
  }

  //! Resets the state of the error.
  void _clearError() {
    setState(() {
      _emailSent = null;
    });
  }

  //! A method to reset the email to firebase.
  void _sendPasswordResetEmail(BuildContext context) async {
    String email = emailController.text.trim();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      setState(() {
        _emailSent = true;
      });
    } catch (e) {
      setState(() {
        _emailSent = false;
      });
    }
  }

  //! The UI for the reset password page, this is presented with a reset title with the correct theme and font.
  //! This code has been reused and the Ui has been changed based on the pages requirements.
  //! This Ui allows the user to input their email using a text controller, and then allows the user to select a button and when it's
  //! Pressed it executes the _sendPasswordResetEmail and then provides the user with an output.
  @override
  Widget build(BuildContext context) {
    double imageWidth = 150;
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        Color cursorColor = themeNotifier.cursorColor();
        final fontProvider = Provider.of<FontProvider>(context);
        Color getContainerColor =
            Provider.of<ThemeNotifier>(context).getContainerColor();
        Color iconColor = themeNotifier.getIconColor();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Reset Password',
              style: fontProvider.getOtherTitleStyle(themeNotifier),
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30.0,
                color: iconColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
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
                        Image.asset(
                          'assets/images/Waving_penguin.png',
                          fit: BoxFit.cover,
                          width: imageWidth,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 400,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: getContainerColor,
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
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: getContainerColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Please Enter Email',
                                textAlign: TextAlign.center,
                                style:
                                    fontProvider.subheadinglogin(themeNotifier),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 400,
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
                                  color: getContainerColor,
                                ),
                                child: TextField(
                                  controller: emailController,
                                  cursorColor: cursorColor,
                                  keyboardType: TextInputType.emailAddress,
                                  style: fontProvider
                                      .subheadinglogin(themeNotifier),
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 14.0,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () => _sendPasswordResetEmail(context),
                    child: Container(
                      width: 100,
                      height: 45,
                      decoration: BoxDecoration(
                        color: getContainerColor,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 8,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Login',
                        style: fontProvider.subheadinglogin(themeNotifier),
                      ),
                    ),
                  ),
                  if (_emailSent != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        _emailSent!
                            ? 'If your email is associated with an account, a password reset email has been sent.'
                            : 'Invalid email format. Please enter a valid email address.',
                        textAlign: TextAlign.center,
                        style: _emailSent!
                            ? fontProvider.greentext()
                            : fontProvider.errortext(),
                      ),
                    ),
                ],
              ),
            ),
          ),
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
                  ])),
        );
      },
    );
  }
}
