import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Pages/Mood%20Tracker/mood_entires_page.dart';
import 'package:big_feelings/Pages/Mood%20Tracker/mood_tracker_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoodOptionPage extends StatelessWidget {
  // ignore: use_super_parameters
  const MoodOptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      //! Using the Provider package to manage theme and font data
      //! Extracting theme and font information from providers
      final currentTheme = themeNotifier.currentTheme;
      final fontProvider = Provider.of<FontProvider>(context);
      final selectedFontFamily = fontProvider.selectedFontFamily;
      //! Determining background,text colors and icon colours based on theme - if dark theme, the text will be white and grey background, if light it will be white background and white text.
      Color backgroundColor = currentTheme == ThemeNotifier.darkTheme
          ? Colors.grey[800]!
          : Colors.white;
      Color textColor =
          currentTheme == ThemeNotifier.darkTheme ? Colors.white : Colors.black;
      Color iconColor =
          currentTheme == ThemeNotifier.darkTheme ? Colors.white : Colors.black;
      return Scaffold(
        appBar: AppBar(
          //! The mood tracker option page presenting two containers that allows the user to track their moods and view their moods.
          title: Text(
            'Welcome to the Mood Options page.',
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
              //! Added space between the title and the track your mood container.
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  //! This navigates to the mood tracker page.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MoodTrackerPage()),
                  );
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    //! Setting the width and height of the containers so they are the same.
                    width: 300,
                    height: 300,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
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
                        //! Mood checkin page.
                        'Mood Check In',
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
              //! Adding space between the two container buttons.
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  //! This navigates to the mood entry page.
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MoodEntriesPage(),
                      ));
                },
                //! This is anotuher container that allows the user to view their mood entries.
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    //! Applying the same width and height for consistency.
                    width: 300,
                    height: 300,
                    //! Adding padding and shadow.
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
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
                        //! View your mood entries option. forwards them to the mood entry page.
                        'View Your Mood Entries',
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
            ],
          ),
        ),
      );
    });
  }
}
