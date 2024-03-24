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
          content: Text(
            'Are you sure you want to delete your account?',
            style: fontProvider.getSubTitleStyle(themeNotifier: themeNotifier),
          ),
          backgroundColor: backgroundColor,
          actions: <Widget>[
            _buildCancelButton(context),
            _buildDeleteButton(
                context, selectedFontFamily, onSuccess), // Pass onSuccess here
          ],
        );
      },
    );
  }

  static Widget _buildCancelButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('No', style: TextStyle(color: Colors.red)),
    );
  }

  static Widget _buildDeleteButton(
      BuildContext context, String selectedFontFamily, VoidCallback onSuccess) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        _handleDelete(context, selectedFontFamily, onSuccess);
      },
      child: Text(
        'Yes',
        style: TextStyle(
          fontFamily: selectedFontFamily,
          fontSize: 16.0,
          color: Colors.green,
        ),
      ),
    );
  }

  static void _handleDelete(
      BuildContext context, String selectedFontFamily, VoidCallback onSuccess) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      deleteUserAccount(user).then((result) {
        if (result == 'success') {
          onSuccess();
        } else {
          final snackBarMessage = result == 'requires-recent-login'
              ? 'Account deletion failed. Authentication required. Please re-sign in again.'
              : 'Error occurred while deleting account.';
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(snackBarMessage), backgroundColor: Colors.red));
        }
      }).catchError((error) {
        logger.e(error);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('An unexpected error occurred.'),
            backgroundColor: Colors.red));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('User not found.'), backgroundColor: Colors.red));
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
