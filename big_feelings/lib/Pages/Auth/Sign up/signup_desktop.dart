// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, use_super_parameters
//! Importing Firebase Authentication package and flutter matrial.
import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Pages/Auth/Sign%20up/errors_signup.dart';
import 'package:big_feelings/Pages/Auth/Terms%20and%20coniditons/terms_condiiton.dart';
import 'package:big_feelings/Pages/Settings%20Page/font_dialog.dart';
import 'package:big_feelings/Pages/Settings%20Page/theme_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

//! A sign Up page, that users can use to create an account, this page is pretty basic,
//! as I just wanted the Sign up button to make accounts for now, the Ui Will look nicer eventually.
//! Defining a stateful widget named SignUpPage.
class Signupdesktop extends StatefulWidget {
  const Signupdesktop({Key? key}) : super(key: key);
  //!Getting state.
  @override
  _SignupdesktopState createState() => _SignupdesktopState();
}

class _SignupdesktopState extends State<Signupdesktop> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _signupError;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_clearError);
    _passwordController.addListener(_clearError);
  }

  void _clearError() {
    setState(() {
      _signupError = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    double imageWidth = 150;
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      Color cursorColor = themeNotifier.cursorColor();
      final fontProvider = Provider.of<FontProvider>(context);
      Color getContainerColor =
          Provider.of<ThemeNotifier>(context).getContainerColor();
      Color iconColor = themeNotifier.getIconColor();
      return Scaffold(
        appBar: AppBar(
          title: Text(
            //! Adding a basic sign up page title in black
            'Sign Up',
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
                              style: fontProvider.desktoplogin(themeNotifier),
                            ),
                            const SizedBox(height: 10),
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
                                color: getContainerColor,
                              ),
                              child: TextField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: cursorColor,
                                style: fontProvider.desktoplogin(themeNotifier),
                                textAlignVertical: TextAlignVertical.center,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 13.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: getContainerColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Please Enter Password',
                              textAlign: TextAlign.center,
                              style: fontProvider.desktoplogin(themeNotifier),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
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
                                  color: getContainerColor,
                                ),
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  cursorColor: cursorColor,
                                  style:
                                      fontProvider.desktoplogin(themeNotifier),
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
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
                const SizedBox(height: 25),
                SizedBox(
                  width: 100,
                  height: 45,
                  child: GestureDetector(
                      onTap: () async {
                        SignUpLogic.signup(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                          (error) {
                            setState(() {
                              _signupError = error;
                            });
                          },
                          context,
                          fontProvider,
                          themeNotifier,
                          _emailController,
                          _passwordController,
                        ).then((_) {
                          if (_signupError == null) {
                            setState(() {
                              _signupError = null;
                            });
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: getContainerColor,
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 8,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Sign Up',
                          style: fontProvider.desktoplogin(themeNotifier),
                        ),
                      )),
                ),
                if (_signupError != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      _signupError!,
                      style: fontProvider.errortext(),
                    ),
                  ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 100,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    barrierColor: Colors.black.withOpacity(0.85),
                    builder: (BuildContext context) {
                      return ThemeDropdownDialog(
                        fontProvider: fontProvider,
                        themeNotifier: themeNotifier,
                      );
                    }),
                child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                    color: getContainerColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
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
              ),
              GestureDetector(
                onTap: () => showDialog(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.85),
                  builder: (context) => const FontDropdownDialog(),
                ),
                child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(right: 20.0),
                  decoration: BoxDecoration(
                    color: getContainerColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Tt',
                    style: fontProvider.buttonText(themeNotifier),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
        bottomSheet: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return TermsAndPrivacyDialog();
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: fontProvider.desktoplogin(themeNotifier),
                children: [
                  TextSpan(
                    text: 'By signing up, you are accepting the ',
                    style: fontProvider.desktoplogin(themeNotifier),
                  ),
                  TextSpan(
                    text: 'Terms & Conditions',
                    style: fontProvider
                        .desktoplogin(themeNotifier)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' and ',
                    style: fontProvider.desktoplogin(themeNotifier),
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: fontProvider
                        .desktoplogin(themeNotifier)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '.',
                    style: fontProvider.desktoplogin(themeNotifier),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
