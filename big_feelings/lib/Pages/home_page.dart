import 'package:big_feelings/Classes/bottom_app_bar.dart.dart';
import 'package:big_feelings/Classes/floating_buttons_bar.dart';
import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//? Ref 38-42
// ignore: use_key_in_widget_constructors
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        final fontProvider = Provider.of<FontProvider>(context);
        Color getContainerColor =
            Provider.of<ThemeNotifier>(context).getContainerColor();
        Color iconColor = themeNotifier.getIconColor();
        //! Setting up spacing variables based on screen width
        final screenWidth = MediaQuery.of(context).size.width;
        double menuItemSpacing = screenWidth * 0.008;
        double minSpacing = 5.0;
        menuItemSpacing = menuItemSpacing.clamp(minSpacing, double.infinity);

        //! Building the Scaffold widget
        return Scaffold(
          //! Setting the current theme as the background colour.
          backgroundColor: themeNotifier.currentTheme.scaffoldBackgroundColor,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              //! Application title on home page, centered with a trasnparent appbar. This has been assigned with the textcolour and the selectedFontFamily.
              'Big Feelings!',
              style: fontProvider.getOtherTitleStyle(themeNotifier),
            ),
            //! This removes the return arrow from the page.
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
                        //! Creating a container for the image with styling.
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
                      //! Positioned FloatingButtonsBar that goes ontop of the image.
                      const Positioned(
                        bottom: 10,
                        child: FloatingButtonsBar(
                          bottomOffset: 20.0,
                        ),
                      ),
                    ],
                  ),
                  //! Adding space between the image and menu items.
                  const SizedBox(height: 10),
                  //! ListView.builder for menu items
                  ListView.builder(
                    shrinkWrap: true,
                    //! Allows the user to be able to scroll up and down the menu items.
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          //! Navigates to the page depending on what they chose.
                          navigateToPage(context, index);
                        },
                        //! The menu item will contain the title, an icon, the selected font family, the menu item spacing and the background colour.
                        child: menuItem(
                          context,
                          menuItems[index]['title'],
                          menuItems[index]['icon'],
                          fontProvider.selectedFontFamily,
                          menuItemSpacing,
                          getContainerColor,
                          iconColor,
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
              //! Handle the home button press- But theres no need for anything to be inside due to already being on the homepage.
            },
            onSettingsPressed: () {
              //! When user selects the settings icon they will be forwarded to the settings page.
              Navigator.pushNamed(context, '/settings-page');
            },
          ),
        );
      },
    );
  }

  //! Function to navigate to the selected page based on the index
  void navigateToPage(BuildContext context, int index) {
    //! A list below has been created to naviagate the user to the selected page using the routes.
    //! The list contains the title of the menu item, the icon and their route.
    Navigator.pushNamed(context, menuItems[index]['route']);
  }

  //? Ref 43-46
  //! Shows the routes, the icons, and the title of each menu item.
  final List<Map<String, dynamic>> menuItems = [
    {
      'title': 'Mini-Games',
      'icon': Icons.gamepad,
      'route': '/mini-game-options',
    },
    {
      'title': 'Mental Health Activities',
      'icon': Icons.favorite,
      'route': '/mental-health-activities',
    },
    {
      'title': 'Your Journal',
      'icon': Icons.book,
      'route': '/journal-options',
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
      'route': '/mood-options',
    },
  ];
  //! Widget for displaying each menu item this contains the parameters, context, title, icon data, font family, spacing and background colour
  Widget menuItem(
      BuildContext context,
      String title,
      IconData icon,
      String selectedFontFamily,
      double spacing,
      Color backgroundColor,
      Color iconColor) {
    final fontProvider = Provider.of<FontProvider>(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    //! Container to hold each menu item with spacing and styling
    return Container(
      margin: EdgeInsets.symmetric(vertical: spacing, horizontal: 16.0),
      //! Styling the container with background color, border radius, and shadow
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
      //! ListTile to structure the menu item with title and their icon - also allows to implement the selected font family into the fontfamily type.
      child: ListTile(
        title: Center(
          child: Text(
            title,
            style: fontProvider.subheading(themeNotifier),
          ),
        ),
        //! Adding the icon colour based on theme changer.
        leading: Icon(icon, color: iconColor),
      ),
    );
  }
}
