import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeDropdownDialog extends StatelessWidget {
  final FontProvider fontProvider;
  final ThemeNotifier themeNotifier; // Add ThemeNotifier

  const ThemeDropdownDialog(
      {Key? key, required this.fontProvider, required this.themeNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentTheme = themeNotifier.currentTheme;
    final fontProvider = Provider.of<FontProvider>(context);
    final selectedFontFamily = fontProvider.selectedFontFamily;

    Color backgroundColor = currentTheme == ThemeNotifier.darkTheme
        ? Colors.grey[800]!
        : Colors.white;
    Color textColor =
        currentTheme == ThemeNotifier.darkTheme ? Colors.white : Colors.black;

    Color iconColor =
        currentTheme == ThemeNotifier.darkTheme ? Colors.white : Colors.black;

    ThemeData? dropdownValue;
    if (currentTheme == ThemeNotifier.darkTheme) {
      dropdownValue = ThemeNotifier.darkTheme;
    } else if (currentTheme == ThemeNotifier.lightTheme) {
      dropdownValue = ThemeNotifier.lightTheme;
    }

    return AlertDialog(
        backgroundColor: backgroundColor,
        title: Text(
          'Select a theme:',
          style: TextStyle(
            fontFamily: selectedFontFamily,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        content: DropdownButton<ThemeData>(
          value: dropdownValue,
          dropdownColor: backgroundColor,
          icon: Icon(Icons.arrow_drop_down, color: iconColor),
          items: <DropdownMenuItem<ThemeData>>[
            DropdownMenuItem<ThemeData>(
              value: ThemeNotifier.darkTheme,
              child: Text(
                'Black background and White text',
                style: TextStyle(
                  fontSize: 15.0,
                  color: textColor,
                  fontFamily: selectedFontFamily,
                ),
              ),
            ),
            DropdownMenuItem<ThemeData>(
              value: ThemeNotifier.lightTheme,
              child: Text(
                'White background and Black text',
                style: TextStyle(
                  fontFamily: selectedFontFamily,
                  fontSize: 15.0,
                  color: textColor,
                ),
              ),
            ),
          ],
          onChanged: (ThemeData? newValue) {
            if (newValue != null && newValue != dropdownValue) {
              themeNotifier.setTheme(newValue);
            }
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              style: TextStyle(
                color: Colors.red,
                fontFamily: selectedFontFamily,
                fontSize: 16.0,
              ),
            ),
          ),
        ]);
  }
}
