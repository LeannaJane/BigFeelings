import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoodOptionPage extends StatelessWidget {
  // ignore: use_super_parameters
  const MoodOptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final fontProvider = Provider.of<FontProvider>(context);
      Color getContainerColor =
          Provider.of<ThemeNotifier>(context).getContainerColor();
      Color iconColor = themeNotifier.getIconColor();

      return Scaffold(
        appBar: AppBar(
          //! The mood tracker option page presenting two containers that allows the user to track their moods and view their moods.
          title: Text(
            'Mood Options',
            style: fontProvider.getOtherTitleStyle(themeNotifier),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30.0,
              color: iconColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //! Added space between the title and the track your mood container.
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  //! This navigates to the mood checker page. I changed this so the page animations worked.
                  Navigator.pushNamed(context, '/mood-checker');
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    //! Setting the width and height of the containers so they are the same.
                    width: 300,
                    height: 180,
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
                      color: getContainerColor,
                    ),
                    child: Center(
                      child: Text(
                        //! Mood checkin page.
                        'Mood Check In',
                        style: fontProvider.subheading(themeNotifier),
                      ),
                    ),
                  ),
                ),
              ),
              //! Adding space between the two container buttons.
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  //! This navigates to the mood entry page.
                  Navigator.pushNamed(context, '/mood-entries');
                },

                //! This is anotuher container that allows the user to view their mood entries.
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    //! Applying the same width and height for consistency.
                    width: 300,
                    height: 180,
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
                      color: getContainerColor,
                    ),
                    child: Center(
                      child: Text(
                        //! View your mood entries option. forwards them to the mood entry page.
                        'View Your Mood Entries',
                        style: fontProvider.subheading(themeNotifier),
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
