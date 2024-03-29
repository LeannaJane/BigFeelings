import 'package:flutter/material.dart';
import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class DeleteAccountDialog {
  static final logger = Logger();

  static void show(BuildContext context, ThemeNotifier themeNotifier,
      FontProvider fontProvider,
      {required VoidCallback onSuccess}) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.85),
      builder: (BuildContext context) {
        final backgroundColor = themeNotifier.getContainerColor();
        final selectedFontFamily = fontProvider.selectedFontFamily;
        return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    //! Message asking if the user wants to delete their account.
                    'Do you want to delete your account?',
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
                  _buildCancelButton(
                      context, selectedFontFamily, fontProvider, themeNotifier),
                  _buildDeleteButton(context, selectedFontFamily, onSuccess,
                      fontProvider, themeNotifier), // Pass onSuccess here
                ],
              )
            ]);
      },
    );
  }

  static Widget _buildCancelButton(
      BuildContext context,
      String selectedFontFamily,
      FontProvider fontProvider,
      ThemeNotifier themeNotifier) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text(
        //! A no text button for cancel action
        'No',
        style: fontProvider
            .subheadingbold(themeNotifier)
            .copyWith(color: Colors.red),
      ),
    );
  }

  static Widget _buildDeleteButton(
      BuildContext context,
      String selectedFontFamily,
      VoidCallback onSuccess,
      FontProvider fontProvider,
      ThemeNotifier themeNotifier) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        _handleDelete(context, selectedFontFamily, onSuccess, fontProvider);
      },
      child: Text(
        'Yes',
        style: fontProvider
            .subheadingbold(themeNotifier)
            .copyWith(color: Colors.green),
      ),
    );
  }

  static void _handleDelete(
    BuildContext context,
    String selectedFontFamily,
    VoidCallback onSuccess,
    FontProvider fontProvider,
  ) {
    final user = FirebaseAuth.instance.currentUser;
    final scaffoldMessenger =
        ScaffoldMessenger.of(context); // Store the ScaffoldMessengerState
    if (user != null) {
      deleteUserAccount(user).then((result) {
        if (result == 'success') {
          onSuccess();
        } else {
          final snackBarMessage = result == 'requires-recent-login'
              ? 'Account deletion failed. Authentication required. Please re-sign in again.'
              : 'Error occurred while deleting account.';
          scaffoldMessenger.showSnackBar(SnackBar(
            content: Text(
              snackBarMessage,
              style: fontProvider
                  .smalltextfontstyle1()
                  .copyWith(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ));
        }
      }).catchError((error) {
        logger.e(error);
        scaffoldMessenger.showSnackBar(const SnackBar(
          content: Text(
            'An unexpected error occurred.',
          ),
          backgroundColor: Colors.red,
        ));
      });
    } else {
      scaffoldMessenger.showSnackBar(const SnackBar(
        content: Text('User not found.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  static Future<String> deleteUserAccount(User user) async {
    try {
      await user.delete();
      return 'success';
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      return e.code;
    } catch (e) {
      logger.e(e);
      return 'unexpected_error';
    }
  }
}
