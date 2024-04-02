// ignore_for_file: use_key_in_widget_constructors

import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorDialog extends StatelessWidget {
  //! List of colours.
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    const Color.fromARGB(255, 255, 90, 145),
    const Color.fromARGB(255, 0, 195, 255),
  ];
  //! List of colour names.
  final List<String> colorNames = ['Red', 'Green', 'Blue', 'Pink', 'Baby Blue'];
  //! Reusing code, and allowing the user to select a colour for the cards.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final fontProvider = Provider.of<FontProvider>(context);
      Color getContainerColor =
          Provider.of<ThemeNotifier>(context).getContainerColor();
      return Material(
          color: Colors.black.withOpacity(0.5),
          child: AlertDialog(
            title: Text(
              'Select a Colour',
              textAlign: TextAlign.center,
              style: fontProvider.subheadingBigBald(themeNotifier),
            ),
            backgroundColor: getContainerColor,
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(colors.length, (index) {
                  final color = colors[index];
                  final colorName = colorNames[index];

                  return GestureDetector(
                    onTap: () => Navigator.of(context).pop(color),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          width: 200,
                          height: 50,
                          child: Center(
                            child: Text(
                              colorName,
                              style: fontProvider.smalltextalert(themeNotifier),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ));
    });
  }
}
