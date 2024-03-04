import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//! Reused the code from the option pages, and edited it to fit the mental health page, to keep constiency, and
//! added the correct page route for the breathing page. :D
class MentalHealthActivitiesPage extends StatelessWidget {
  // ignore: use_super_parameters
  const MentalHealthActivitiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final currentTheme = themeNotifier.currentTheme;
      final fontProvider = Provider.of<FontProvider>(context);
      final selectedFontFamily = fontProvider.selectedFontFamily;
      Color backgroundColor = currentTheme == ThemeNotifier.darkTheme
          ? Colors.grey[800]!
          : Colors.white;
      Color textColor =
          currentTheme == ThemeNotifier.darkTheme ? Colors.white : Colors.black;
      //Color iconColor =
      //currentTheme == ThemeNotifier.darkTheme ? Colors.white : Colors.black;
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Welcome to the Mental health acivity page.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: selectedFontFamily,
            ),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/breathing-page');
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    width: 300,
                    height: 300,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: backgroundColor,
                    ),
                    child: Center(
                      child: Text(
                        'Breathing exercise',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: selectedFontFamily,
                          fontSize: 16.0,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {},
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    width: 300,
                    height: 300,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 30.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: backgroundColor,
                    ),
                    child: Center(
                      child: Text(
                        'Other activity not completed',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: selectedFontFamily,
                          fontSize: 16.0,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
