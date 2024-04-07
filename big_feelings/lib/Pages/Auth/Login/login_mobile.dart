// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, use_super_parameters
//! Importing Firebase Authentication package and flutter matrial.
import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Pages/Auth/Login/login_logic.dart';
import 'package:big_feelings/Pages/Settings%20Page/font_dialog.dart';
import 'package:big_feelings/Pages/Settings%20Page/theme_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

//! A sign Up page, that users can use to create an account, this page is pretty basic,
//! as I just wanted the Sign up button to make accounts for now, the Ui Will look nicer eventually.
//! Defining a stateful widget named SignUpPage.
class LoginMobilePage extends StatefulWidget {
  const LoginMobilePage({Key? key}) : super(key: key);

  @override
  _LoginMobilePageState createState() => _LoginMobilePageState();
}

class _LoginMobilePageState extends State<LoginMobilePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? _loginError;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_clearError);
    passwordController.addListener(_clearError);
  }

  void _clearError() {
    setState(() {
      _loginError = null;
    });
  }

  void _forgotPassword(BuildContext context) {
    Navigator.pushNamed(context, '/reset-mobile');
  }

  //! This code has been edited to fit the Ui with the correct theme and font provider.
  //! I set a constant image width to keep the image size constant through the app and Ui layouts.
  //! The elevated buttons have all been changed to containers with gestures due to wanting shadows
  @override
  Widget build(BuildContext context) {
    double imageWidth = 100;
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      Color cursorColor = themeNotifier.cursorColor();
      final fontProvider = Provider.of<FontProvider>(context);
      Color getContainerColor =
          Provider.of<ThemeNotifier>(context).getContainerColor();
      Color iconColor = themeNotifier.getIconColor();
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Login',
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
                const SizedBox(height: 10),
                Container(
                  width: 400,
                  padding: const EdgeInsets.only(
                      right: 8, left: 8, top: 8, bottom: 26),
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
                        padding: const EdgeInsets.only(
                          right: 8,
                          left: 8,
                        ),
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
                            Padding(
                              padding: const EdgeInsets.only(right: 8, left: 8),
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
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: cursorColor,
                                  style:
                                      fontProvider.desktoplogin(themeNotifier),
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 18, bottom: 14, right: 10),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.only(
                          right: 8,
                          left: 8,
                        ),
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
                              padding: const EdgeInsets.only(
                                  right: 8, left: 8, bottom: 8),
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
                                  controller: passwordController,
                                  obscureText: true,
                                  cursorColor: cursorColor,
                                  style:
                                      fontProvider.desktoplogin(themeNotifier),
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 18, bottom: 10, right: 10),
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
                GestureDetector(
                  onTap: () => _handleLogin(context),
                  child: Container(
                    width: 150,
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
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => _forgotPassword(context),
                  child: Text(
                    'Forgot Password?',
                    textAlign: TextAlign.center,
                    style: fontProvider.greentext(),
                  ),
                ),
                const SizedBox(height: 5),
                if (_loginError != null)
                  Center(
                    child: Text(
                      _loginError!,
                      textAlign: TextAlign.center,
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
      );
    });
  }

  //! Moved the login state to own method.
  void _handleLogin(BuildContext context) {
    LoginLogic.login(
      context,
      emailController,
      passwordController,
      (error) {
        setState(() {
          _loginError = error;
        });
      },
      () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      },
      (userId) {
        Navigator.pushReplacementNamed(context, '/home');
      },
      _forgotPassword,
    );
  }
}
