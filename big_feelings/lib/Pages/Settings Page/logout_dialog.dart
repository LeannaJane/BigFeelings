import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//? Ref 69
class LogoutDialog {
  static void show(BuildContext context, ThemeNotifier themeNotifier,
      FontProvider fontProvider) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.85),
      builder: (BuildContext context) {
        final backgroundColor = themeNotifier.getContainerColor();
        final selectedFontFamily = fontProvider.selectedFontFamily;
        return AlertDialog(
          //! Dialog content that asks user if they want to log out.
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  //! Message asking if the user wants to log out.
                  'Do you want to log out?',
                  style: fontProvider.getSubTitleStyle(
                    themeNotifier: themeNotifier,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: backgroundColor,
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //! cancel button
                _buildCancelButton(
                    context, selectedFontFamily, fontProvider, themeNotifier),
                //! logout button with the font family assigned.
                _buildLogoutButton(
                    context, selectedFontFamily, themeNotifier, fontProvider),
              ],
            ),
          ],
        );
      },
    );
  }

  //! Widget for cancel button
  static Widget _buildCancelButton(
      BuildContext context,
      String selectedFontFamily,
      FontProvider fontProvider,
      ThemeNotifier themeNotifier) {
    return TextButton(
      onPressed: () {
        //! Checks if the context is still valid before popping the dialog
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Text(
        //! A no text button for cancel action
        'No',
        style: fontProvider
            .subheadingbold(themeNotifier)
            .copyWith(color: Colors.red),
      ),
    );
  }

  //! Widget for logout button
  static Widget _buildLogoutButton(
      BuildContext context,
      String selectedFontFamily,
      ThemeNotifier themeNotifier,
      FontProvider fontProvider) {
    return TextButton(
      //! Check if the context is still valid before handling logout
      onPressed: () async {
        if (context.mounted) {
          await _handleLogout(context);
        }
      },
      child: Text(
        //! Yes text button for logout action
        'Yes',
        style: fontProvider
            .subheadingbold(themeNotifier)
            .copyWith(color: Colors.green),
      ),
    );
  }

  //? Ref 70
  //! Method to handle logout
  static Future<void> _handleLogout(BuildContext context) async {
    await FirebaseAuth.instance
        //! Sign out the user using Firebase authentication
        .signOut();
    if (context.mounted) {
      //! Check if the context is still valid before navigating
      Navigator.of(context).pushReplacementNamed('/');
    }
  }
}
