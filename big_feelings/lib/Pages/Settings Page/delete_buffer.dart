// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Pages/Auth/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DeletingBufferingPage extends StatefulWidget {
  @override
  _DeletingBufferingPageState createState() => _DeletingBufferingPageState();
}

class _DeletingBufferingPageState extends State<DeletingBufferingPage> {
  @override
  void initState() {
    super.initState();
    deleteUserAccount();
  }

  static final logger = Logger();
  //! This method returns the user to the welcome page, no matter the error.
  Future<void> deleteUserAccount() async {
    try {
      await FirebaseAuth.instance.currentUser?.delete();
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Future.delayed(const Duration(seconds: 6));
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WelcomePage()),
          );
        }
      });
    } catch (e) {
      logger.e('An error occurred while deleting the account: $e');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WelcomePage()),
          );
        }
      });
    }
  }

  //! This is a delete icon buffer page, for when the user deletes their account. If they select yes, they will delete their account, it will show the
  //! Deleting buffer and return them to the welcome page. I use a lottie animation underneath the delete text, as a penguine.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final fontProvider = Provider.of<FontProvider>(context);
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                'Deleting Account',
                style: fontProvider.getTitleFontStyle(themeNotifier),
              ),
              SizedBox(
                height: 120,
                child: OverflowBox(
                  minHeight: 300,
                  maxHeight: 400,
                  alignment: Alignment.topCenter,
                  //? Ref 25
                  child: Lottie.asset("assets/animation/penguindance.json"),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
