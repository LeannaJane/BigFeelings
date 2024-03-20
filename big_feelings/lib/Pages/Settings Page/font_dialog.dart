// ignore_for_file: use_super_parameters

import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FontDropdownDialog extends StatelessWidget {
  const FontDropdownDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<FontProvider, ThemeNotifier>(
      builder: (context, fontProvider, themeNotifier, child) {
        final selectedFontFamily = fontProvider.selectedFontFamily;
        Color getContainerColor = themeNotifier.getContainerColor();
        return Center(
          child: SizedBox(
            width: 350.0,
            height: 400.0,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: AlertDialog(
                backgroundColor: getContainerColor,
                title: Text(
                  'Select a font:',
                  style: fontProvider.getSubTitleStyle(
                    themeNotifier: themeNotifier,
                  ),
                ),
                //! The value of the font chosen is selected to the origional selected font.
                content: DropdownButton<String>(
                  dropdownColor: getContainerColor,
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
                          .copyWith(color: Colors.red),
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
