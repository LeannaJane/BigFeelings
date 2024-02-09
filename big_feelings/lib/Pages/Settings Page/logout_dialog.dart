import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/*
Reference:Stack Overflow. (n.d.). How to prompt user to logout in flutter? [online] Available at: https://stackoverflow.com/questions/58210126/how-to-prompt-user-to-logout-in-flutter [Accessed 7 Feb. 2024].
This website was used to help me understand how to logout. But can be also used to return to another page or exit from the webpage.
*/

class LogoutDialog {
  // Method to show the log out dialog. Which is basically yes or no.
  static void show(BuildContext context, String selectedFontFamily,
      Color backgroundColor, Color textColor) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.85),
      builder: (BuildContext context) {
        return AlertDialog(
          // Dialog content that asks user if they want to log out.
          content: Text(
            'Do you want to log out?', // Message asking if the user wants to log out.
            style: TextStyle(
              fontFamily: selectedFontFamily, // Selected font family.
              fontSize: 20.0, // 20.0 font size and set to bald.
              color: textColor,
            ),
          ),
          backgroundColor: backgroundColor,
          actions: <Widget>[
            _buildCancelButton(context,
                selectedFontFamily), // cancel button and logout button with the font family assigned.
            _buildLogoutButton(context, selectedFontFamily),
          ],
        );
      },
    );
  }

  // Widget for cancel button
  static Widget _buildCancelButton(
      BuildContext context, String selectedFontFamily) {
    return TextButton(
      onPressed: () {
        // Checks if the context is still valid before popping the dialog
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Text(
        'No', // A no text button for cancel action
        style: TextStyle(
          fontFamily: selectedFontFamily, // Set font family for the button text
          fontSize: 16.0, // Set font size for the button text
          color: Colors.red, // Set text color for the button text
        ),
      ),
    );
  }

  // Widget for logout button
  static Widget _buildLogoutButton(
      BuildContext context, String selectedFontFamily) {
    return TextButton(
      // Check if the context is still valid before handling logout
      onPressed: () async {
        if (context.mounted) {
          await _handleLogout(context);
        }
      },
      child: Text(
        'Yes', // Yes text button for logout action
        style: TextStyle(
          fontFamily: selectedFontFamily, // Set font family for the button text
          fontSize: 16.0, // Set font size for the button text
          color: Colors.green, // Set text color for the button text
        ),
      ),
    );
  }

  /*
  Reference
  GeeksforGeeks. (2022). Flutter - Implementing Signing Out the User. [online] Available at: https://www.geeksforgeeks.org/flutter-implementing-signing-out-the-user/ [Accessed 7 Feb. 2024].
  I origionally used the code provided from geekforgeeks but I kept recieving a error that you cannot use async with context. 
  So I changed it to a context.mounted.
  */
  // Method to handle logout
  static Future<void> _handleLogout(BuildContext context) async {
    await FirebaseAuth.instance
        .signOut(); // Sign out the user using Firebase authentication
    if (context.mounted) {
      // Check if the context is still valid before navigating
      Navigator.of(context).pushReplacementNamed('/');
    }
  }
}
