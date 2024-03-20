// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously
//! Importing Firebase Authentication package and flutter matrial.
import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Pages/Auth/Login/login_logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//! A sign Up page, that users can use to create an account, this page is pretty basic,
//! as I just wanted the Sign up button to make accounts for now, the Ui Will look nicer eventually.
//! Defining a stateful widget named SignUpPage.
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    Navigator.pushNamed(context, '/password_reset');
  }

  //! This code has been edited to fit the Ui with the correct theme and font provider.
  //! I set a constant image width to keep the image size constant through the app and Ui layouts.
  //! The elevated buttons have all been changed to containers with gestures due to wanting shadows
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
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: cursorColor,
                                style:
                                    fontProvider.subheadinglogin(themeNotifier),
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
                              style:
                                  fontProvider.subheadinglogin(themeNotifier),
                            ),
                            const SizedBox(height: 8),
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
                                  controller: passwordController,
                                  obscureText: true,
                                  cursorColor: cursorColor,
                                  style: fontProvider
                                      .subheadinglogin(themeNotifier),
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
                GestureDetector(
                  onTap: () => _handleLogin(context),
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
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => _forgotPassword(context),
                  child: Text(
                    'Forgot Password?',
                    textAlign: TextAlign.center,
                    style: fontProvider.greentext(),
                  ),
                ),
                if (_loginError != null)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        _loginError!,
                        style: fontProvider.errortext(),
                      ),
                    ),
                  ),
              ],
            ),
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
