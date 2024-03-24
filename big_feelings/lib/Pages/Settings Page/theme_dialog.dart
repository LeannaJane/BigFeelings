import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeDropdownDialog extends StatelessWidget {
  final FontProvider fontProvider;
  final ThemeNotifier themeNotifier; // Add ThemeNotifier

  // ignore: use_super_parameters
  const ThemeDropdownDialog(
      {Key? key, required this.fontProvider, required this.themeNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //! Using the Provider package to manage theme and font data
    //! Extracting theme and font information from providers
    final currentTheme = themeNotifier.currentTheme;
    //! Determining background,text colours, icon colours based on theme - if dark theme, the text will be white and grey background, if light it will be white background and white text.

    final fontProvider = Provider.of<FontProvider>(context);
    Color getContainerColor =
        Provider.of<ThemeNotifier>(context).getContainerColor();
    Color iconColor = themeNotifier.getIconColor();

    //! -Setting the initial value for the theme dropdown
    ThemeData? dropdownValue;
    if (currentTheme == ThemeNotifier.darkTheme) {
      dropdownValue = ThemeNotifier.darkTheme;
    } else if (currentTheme == ThemeNotifier.lightTheme) {
      dropdownValue = ThemeNotifier.lightTheme;
    }
    //! Building the Scaffold widget
    return AlertDialog(
        backgroundColor: getContainerColor,
        title: Text(
          //! Select a theme option in settings page with the chosen font family.
          'Select a theme:',
          style: fontProvider.getSubTitleStyle(
            themeNotifier: themeNotifier,
          ),
        ),
        //! Presenting the drop down selections with the textColour theme and background colours applied.
        content: DropdownButton<ThemeData>(
          value: dropdownValue,
          dropdownColor: getContainerColor,
          icon: Icon(Icons.arrow_drop_down, color: iconColor),
          items: <DropdownMenuItem<ThemeData>>[
            DropdownMenuItem<ThemeData>(
              value: ThemeNotifier.darkTheme,
              child: Text('Dark Theme',
                  style: fontProvider.subheadingbald(themeNotifier)),
            ),
            DropdownMenuItem<ThemeData>(
              value: ThemeNotifier.lightTheme,
              child: Text('Light Theme',
                  style: fontProvider.subheadingbald(themeNotifier)),
            ),
          ],
          onChanged: (ThemeData? newValue) {
            //! Update the theme when a new one is selected
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
            //! A piece of text that allows the user to select ok to return back to the settings page without confusion.
            child: Text(
              'OK',
              style:
                  fontProvider.smalltextfontstyle().copyWith(color: Colors.red),
            ),
          ),
        ]);
  }
}
