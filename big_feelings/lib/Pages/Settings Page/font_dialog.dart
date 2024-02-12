import 'package:big_feelings/Classes/font_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
! Reference
* Android Developers. (n.d.). Work with fonts | Jetpack Compose. [online] Available at: https://developer.android.com/jetpack/compose/text/fonts [Accessed 3 Feb. 2024].
* This website assisted in me setting fonts.

* www.youtube.com. (n.d.). Custom Font in Flutter | Flutter external font | Flutter Tutorial #14. [online] Available at: https://www.youtube.com/watch?v=qI_7znKKlhA [Accessed 3 Feb. 2024].

* www.youtube.com. (n.d.). Flutter Tutorial - Full Course - Project Based. [online] Available at: https://www.youtube.com/watch?v=OO_-MbnXQzY [Accessed 3 Feb. 2024].

* docs.flutter.dev. (n.d.). Work with long lists. [online] Available at: https://docs.flutter.dev/cookbook/lists/long-lists.

* The flutter website helped me into creating a list.
‌
* api.flutter.dev. (n.d.). actions property - AppBar class - material library - Dart API. [online] Available at: https://api.flutter.dev/flutter/material/AppBar/actions.html [Accessed 6 Feb. 2024].
* Implemented an action widget using the code provided by flutter to assist me.
‌   
* I had an issue where the fonts were not updating to the selected font on the drop down, so this website helped me understand how to use an alert dialog.
* Stack Overflow. (n.d.). How to refresh an AlertDialog in Flutter? [online] Available at: https://stackoverflow.com/questions/51962272/how-to-refresh-an-alertdialog-in-flutter [Accessed 6 Feb. 2024].
* This website also helped me understand how to write my show dialog dropdown using a stateful builder.
‌  

* I used this website to understand how to change the opacity of the dimming in the background the line:
* backgroundColor: Colors.white.withOpacity(0.85),
* Stack Overflow. (n.d.). How to make a full screen dialog in flutter? [online] Available at: https://stackoverflow.com/questions/51908187/how-to-make-a-full-screen-dialog-in-flutter [Accessed 6 Feb. 2024].
*/
class FontDropdownDialog extends StatelessWidget {
  // ignore: use_super_parameters
  const FontDropdownDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FontProvider>(
      builder: (context, fontProvider, child) {
        final selectedFontFamily = fontProvider.selectedFontFamily;

        return Center(
          // Wrap AlertDialog with Center
          child: SizedBox(
            width: 350.0, // Fixed width for AlertDialog
            height: 400.0, // Fixed height for AlertDialog
            child: SingleChildScrollView(
              physics:
                  const NeverScrollableScrollPhysics(), // Disable scrolling
              // Wrap with SingleChildScrollView
              child: AlertDialog(
                title: Text(
                  'Select a font:',
                  style: fontProvider.getSubTitleStyle(),
                ),
                content: DropdownButton<String>(
                  //! The value of the font chosen is selected to the origional selected font.
                  value: selectedFontFamily,
                  padding: EdgeInsets.zero,
                  //! Stack Overflow. (n.d.). flutter DropDownButton remove arrow icon? [online] Available at: https://stackoverflow.com/questions/67997560/flutter-dropdownbutton-remove-arrow-icon [Accessed 12 Feb. 2024].
                  //! Hiding the default icon.
                  iconSize: 0.0,
                  items: fontProvider.supportedFontFamilies
                      .map((String fontFamily) {
                    final bool isSelected = fontFamily == selectedFontFamily;
                    return DropdownMenuItem<String>(
                      value: fontFamily,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //! The font family text is set to their font family type
                          Text(
                            fontFamily,
                            style: fontProvider.getRegularFontStyle(
                              fontFamily: fontFamily,
                            ),
                          ),
                          //! Adds a dropdown icon to the selected font.
                          if (isSelected)
                            const Icon(Icons.arrow_drop_down, size: 24.0),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    //! IF the new value isnt null then the new state will be updated with the selected font.
                    if (newValue != null) {
                      //! Update selectedFont immediately when the user selects a different font
                      fontProvider.setFontFamily(newValue);
                      //! If not it stays the same until the user selects apply.
                    }
                  },
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      //! Adding the Ok text
                      'Ok',
                      style: fontProvider
                          .smalltextfontstyle()
                          .copyWith(color: Colors.red), // Use red color
                    ),
                  ),
                ],
                // Align actions to the right
                actionsAlignment: MainAxisAlignment.end,
              ),
            ),
          ),
        );
      },
    );
  }
}
