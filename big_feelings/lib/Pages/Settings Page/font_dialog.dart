import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
Reference
Android Developers. (n.d.). Work with fonts | Jetpack Compose. [online] Available at: https://developer.android.com/jetpack/compose/text/fonts [Accessed 3 Feb. 2024].
This website assisted in me setting fonts.
‌Reference 
www.youtube.com. (n.d.). Custom Font in Flutter | Flutter external font | Flutter Tutorial #14. [online] Available at: https://www.youtube.com/watch?v=qI_7znKKlhA [Accessed 3 Feb. 2024].
Reference:
www.youtube.com. (n.d.). Flutter Tutorial - Full Course - Project Based. [online] Available at: https://www.youtube.com/watch?v=OO_-MbnXQzY [Accessed 3 Feb. 2024].

‌Reference:
docs.flutter.dev. (n.d.). Work with long lists. [online] Available at: https://docs.flutter.dev/cookbook/lists/long-lists.
The flutter website helped me into creating a list.
‌

  
api.flutter.dev. (n.d.). actions property - AppBar class - material library - Dart API. [online] Available at: https://api.flutter.dev/flutter/material/AppBar/actions.html [Accessed 6 Feb. 2024].
  Implemented an action widget using the code provided by flutter to assist me.
‌   
I had an issue where the fonts were not updating to the selected font on the drop down, so this website helped me understand how to use an alert dialog.
  Stack Overflow. (n.d.). How to refresh an AlertDialog in Flutter? [online] Available at: https://stackoverflow.com/questions/51962272/how-to-refresh-an-alertdialog-in-flutter [Accessed 6 Feb. 2024].
  This website also helped me understand how to write my show dialog dropdown using a stateful builder.
‌  

I used this website to understand how to change the opacity of the dimming in the background the line:
  backgroundColor: Colors.white.withOpacity(0.85),
  Stack Overflow. (n.d.). How to make a full screen dialog in flutter? [online] Available at: https://stackoverflow.com/questions/51908187/how-to-make-a-full-screen-dialog-in-flutter [Accessed 6 Feb. 2024].

*/

// Changed the font dialog into own class.
class FontDropdownDialog extends StatelessWidget {
  const FontDropdownDialog({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final currentTheme = themeNotifier.currentTheme;

      // Accessing THE fontprovider to get the selected font family.
      final fontProvider = Provider.of<FontProvider>(context);
      final selectedFontFamily = fontProvider.selectedFontFamily;

      // Variables based on the theme.

      Color backgroundColor = currentTheme == ThemeNotifier.darkTheme
          ? Colors.grey[800]!
          : Colors.white;
      Color textColor =
          currentTheme == ThemeNotifier.darkTheme ? Colors.white : Colors.black;

      Color iconColor =
          currentTheme == ThemeNotifier.darkTheme ? Colors.white : Colors.black;
      // Dialog title with the selected font family applied.
      return AlertDialog(
        backgroundColor: backgroundColor,
        title: Text(
          'Select a font:',
          style: TextStyle(
            // Setting the font size of the button for now.
            fontFamily: selectedFontFamily,
            // Setting the font size of the button for now.
            fontSize: 20.0,
            // Fontweight set to bald to let the user know what they are doing.
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        // Once the user selects a font all the text will change to that font
        content: DropdownButton<String>(
          // The value of the font chosen is selected to the origional selected font.
          value: selectedFontFamily,
          dropdownColor:
              backgroundColor, // Set the background color of the dropdown menu
          icon: Icon(Icons.arrow_drop_down,
              color: iconColor), // Set the color of the dropdown icon
          items: fontProvider.supportedFontFamilies.map((String fontFamily) {
            return DropdownMenuItem<String>(
              value: fontFamily,
              child: Text(
                fontFamily,
                style: TextStyle(
                  // The font family text is set to their font family type
                  fontFamily: fontFamily,
                  // Setting the font size.
                  fontSize: 15.0,
                  color:
                      textColor, // Setting the text colour to textcolor which is changed based on the theme.
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            // IF the new value isnt null then the new state will be updated with the selected font.
            if (newValue != null) {
              // Update selectedFont immediately when the user selects a different font
              fontProvider.setFontFamily(newValue);
              // If not it stays the same until the user selects apply.
            }
          },
        ),
        actions: <Widget>[
          // A button that cancels the choices made.
          TextButton(
            onPressed: () {
              fontProvider.setFontFamily(selectedFontFamily);
              Navigator.of(context).pop();
            },
            child: Text(
              'Ok', // Adding the Ok text
              style: TextStyle(
                fontFamily: selectedFontFamily, // Setting the font family.
                fontSize: 16.0, // Setting the font size
                color: Colors.red, // Setting the font colour.
              ),
            ),
          ),
        ],
      );
    });
  }
}
