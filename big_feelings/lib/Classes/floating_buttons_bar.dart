import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FloatingButtonsBar extends StatelessWidget {
  final double height;
  final double width;
  final double bottomOffset;
  final double leftOffset;

  const FloatingButtonsBar({
    super.key,
    this.height = 50.0,
    this.width =
        50.0, // This is the height and width of the floating buttons, all the buttons have the same width and height for consistency.
    this.bottomOffset = 40.0, // This is the vertical offset
    this.leftOffset =
        16.0, // This is the horizontal offset for left and right buttons
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final currentTheme = themeNotifier.currentTheme;

      // Define the color for the buttons based on the current theme
      Color buttonColor = currentTheme == ThemeNotifier.darkTheme
          ? Colors.grey[800]! // Set the color to grey for dark theme
          : Colors.white; // Set the color to white for light theme

      // Define the icon color based on the current theme
      Color iconColor = currentTheme == ThemeNotifier.darkTheme
          ? Colors.white // Set the icon color to white for dark theme
          : Colors.black; // Set the icon color to black for light theme

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Changed to a sized box to fix the a container error. As they were uncessasry.
          SizedBox(
            width: width,
            height: height,
            child: FloatingActionButton(
              onPressed: () {},
              tooltip: 'Shirt',
              heroTag: 'btn1',
              backgroundColor: buttonColor,
              child: Icon(Icons.shopping_bag, color: iconColor),
            ),
          ),
          SizedBox(width: leftOffset), // Space between buttons
          SizedBox(
            width: width,
            height: height,
            child: FloatingActionButton(
              onPressed: () {},
              tooltip: 'Heart',
              heroTag: 'btn2',
              backgroundColor: buttonColor,
              child: Icon(Icons.shopping_bag, color: iconColor),
            ),
          ),
          SizedBox(width: leftOffset), // Space between buttons
          SizedBox(
            width: width,
            height: height,
            child: FloatingActionButton(
              onPressed: () {},
              tooltip: 'Fork and Knife',
              heroTag: 'btn3',
              backgroundColor: buttonColor,
              child: Icon(Icons.shopping_bag, color: iconColor),
            ),
          ),
        ],
      );
    });
  }
}
