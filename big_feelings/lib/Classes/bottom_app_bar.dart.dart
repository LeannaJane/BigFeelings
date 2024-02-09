import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';

// Moved class into its own lib.
class CustomBottomAppBar extends StatelessWidget {
  final VoidCallback onHomePressed;
  final VoidCallback onSettingsPressed;
  // A constuctor used to initlise the call backs.
  const CustomBottomAppBar({
    Key? key,
    required this.onHomePressed,
    required this.onSettingsPressed,
  }) : super(key: key);

  // This creates a bottom app bar that has a transparent background, and the elevation is set to 0, to
  // remove the shadow of the bottom app bar.

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        final currentTheme = themeNotifier.currentTheme;

        // Define the color for the buttons based on the current theme
        Color buttonColor = currentTheme == ThemeNotifier.darkTheme
            ? Colors.grey[800]! // Set the color to grey for dark theme
            : Colors.white; // Set the color to white for light theme

        // Define the icon color based on the current theme
        Color iconColor = currentTheme == ThemeNotifier.darkTheme
            ? Colors.white // Set the icon color to white for dark theme
            : Colors.black; // Set the icon color to black for light theme

        return BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    onPressed: onHomePressed,
                    tooltip: 'Home',
                    heroTag: 'homeBtn',
                    backgroundColor: buttonColor,
                    child: Icon(Icons.home, color: iconColor, size: 30),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(right: 16),
                child: SizedBox(
                  // Adding width and height for the button, to control it.
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    onPressed: onSettingsPressed,
                    tooltip: 'Settings',
                    heroTag: 'settingsBtn',
                    backgroundColor: buttonColor, // Use buttonColor here
                    child: Icon(Icons.settings, color: iconColor, size: 30),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
