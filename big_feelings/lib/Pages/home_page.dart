import 'package:big_feelings/Classes/bottom_app_bar.dart.dart';
import 'package:big_feelings/Classes/floating_buttons_bar.dart';
import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
Reference:
GeeksforGeeks. (2023). Flutter - Elevation in AppBar. [online] Available at: https://www.geeksforgeeks.org/flutter-elevation-in-appbar/ [Accessed 5 Feb. 2024].
This website helped me understand how to remove the shadow from the bottom appbar.

Reference
GitHub. (n.d.). Inner ListView.builder with shrinkWrap as true builds all children at once · Issue #26072 · flutter/flutter. [online] Available at: https://github.com/flutter/flutter/issues/26072 [Accessed 5 Feb. 2024].
This was used to help me fix a issue with my code.
‌
Reference:
Kumar, Y. (2020). ListView in Flutter. [online] The Startup. Available at: https://medium.com/swlh/listview-in-flutter-222caba33e42 [Accessed 5 Feb. 2024].

‌Flutterdynasty (2023). Listview.builder in Flutter. [online] Medium. Available at: https://medium.com/@flutterdynasty/listview-builder-in-flutter-e54a8fa2c7a0 [Accessed 5 Feb. 2024].

‌dartpad.dev. (n.d.). DartPad Workshops. [online] Available at: https://dartpad.dev/workshops.html?webserver=https://fdr-shrinkwrap-slivers.web.app#Step2 [Accessed 5 Feb. 2024].

Gupta, D. (2018). Flutter: Displaying Dynamic Contents using ListView.builder. [online] Medium. Available at: https://medium.com/@CognitiveProgrammer/flutter-displaying-dynamic-contents-using-listview-builder-f2cedb1a19fb [Accessed 5 Feb. 2024].

‌
‌

*/

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        final currentTheme = themeNotifier.currentTheme;
        final fontProvider = Provider.of<FontProvider>(context);
        final selectedFontFamily = fontProvider.selectedFontFamily;
        final screenWidth = MediaQuery.of(context).size.width;
        double menuItemSpacing = screenWidth * 0.008;
        double minSpacing = 5.0;
        menuItemSpacing = menuItemSpacing.clamp(minSpacing, double.infinity);

        Color backgroundColor = currentTheme == ThemeNotifier.darkTheme
            ? Colors.grey[800]!
            : Colors.white;
        Color textColor = currentTheme == ThemeNotifier.darkTheme
            ? Colors.white
            : Colors.black;

        return Scaffold(
          backgroundColor: themeNotifier.currentTheme.scaffoldBackgroundColor,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Big Feelings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: selectedFontFamily,
                fontSize: 30.0,
                color: textColor,
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 240,
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
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
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset('assets/images/Penguin.png',
                              fit: BoxFit.cover),
                        ),
                      ),
                      const Positioned(
                        bottom: 10,
                        child: FloatingButtonsBar(
                          bottomOffset: 20.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          navigateToPage(context, index);
                        },
                        child: menuItem(
                          context,
                          menuItems[index]['title'],
                          menuItems[index]['icon'],
                          selectedFontFamily,
                          menuItemSpacing,
                          backgroundColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: CustomBottomAppBar(
            onHomePressed: () {
              // Handle the home button press
            },
            onSettingsPressed: () {
              Navigator.pushNamed(context, '/settings-page');
            },
          ),
        );
      },
    );
  }

  void navigateToPage(BuildContext context, int index) {
    Navigator.pushNamed(context, menuItems[index]['route']);
  }

/*
 Reference:
 Sarkar, M. (2023). Flutter ListView Widget Full Tutorial. [online] All About Flutter | Flutter and Dart. Available at: https://www.allaboutflutter.com/flutter-listview-widget-full-tutorial [Accessed 5 Feb. 2024].
 www.youtube.com. (n.d.). Add Dynamic Items to ListView in Flutter using GetX || Flutter || GetX. [online] Available at: https://www.youtube.com/watch?v=3G-dPzwO9s4 [Accessed 5 Feb. 2024].

  How to Flutter. (n.d.). Maps & Sets. [online] Available at: https://howtoflutter.dev/dart/data-types/maps-sets/ [Accessed 5 Feb. 2024].

‌Hire Developers, Free Coding Resources for the Developer. (n.d.). [Solved]-List to List Dart-Flutter. [online] Available at: https://www.appsloveworld.com/flutter/200/223/listmapstringdynamic-to-liststring-dart [Accessed 5 Feb. 2024].
This website provided sample code that helped me understand how to organise using kmaps to strcute data.
‌I made modifications to align it with my code. 
I made a method that navigates the user depedning on their menu item index and it will send the user to the correct route/page.
*/

  // Function to navigate to the selected page based on the index.

  // Shows the routes, the icons, and the title of each menu item.
  final List<Map<String, dynamic>> menuItems = [
    {
      'title': 'Breathing',
      'icon': Icons.adjust,
      'route': '/breathing',
    },
    {
      'title': 'Mini-Games',
      'icon': Icons.gamepad,
      'route': '/mini-games',
    },
    {
      'title': 'Mental Health Activities',
      'icon': Icons.favorite,
      'route': '/mental-health-activities',
    },
    {
      'title': 'Your Journal',
      'icon': Icons.book,
      'route': '/your-journal',
    },
    {
      'title': 'Library',
      'icon': Icons.library_books,
      'route': '/library',
    },
    {
      'title': 'Quizzes',
      'icon': Icons.question_answer,
      'route': '/quizzes',
    },
    {
      'title': 'Mood Tracker',
      'icon': Icons.mood,
      'route': '/mood-tracker',
    },
  ];
  // Added the spacing parameter in here.
  Widget menuItem(BuildContext context, String title, IconData icon,
      String selectedFontFamily, double spacing, Color backgroundColor) {
    return Container(
      margin: EdgeInsets.symmetric(
          // Adding spacing between the menu items.
          vertical: spacing,
          horizontal: 16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Center(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: selectedFontFamily, // Assigning the font family.
              fontSize: 16.0,
            ),
          ),
        ),
        leading: Icon(icon, color: Colors.black),
      ),
    );
  }
}
