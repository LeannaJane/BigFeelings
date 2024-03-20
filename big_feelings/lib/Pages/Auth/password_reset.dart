import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController emailController = TextEditingController();
  bool? _emailSent;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_clearError);
  }

  void _clearError() {
    setState(() {
      _emailSent = null;
    });
  }

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
                  if (_emailSent == false)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Error sending password reset email.',
                        style: fontProvider.errortext(),
                      ),
                    ),
                  if (_emailSent == true)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        'An email has been sent to reset your password.',
                        style: fontProvider.getSubTitleStyle(
                            textcolour: Colors.green),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
