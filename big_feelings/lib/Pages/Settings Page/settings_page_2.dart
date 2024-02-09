import 'package:big_feelings/Classes/bottom_app_bar.dart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Pages/Settings%20Page/font_dialog.dart';
import 'package:big_feelings/Pages/Settings%20Page/logout_dialog.dart';
import 'package:big_feelings/Pages/Settings%20Page/theme_dialog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Adding the same menu spacing I used in the home page.
  double menuItemSpacing = 10.0;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        final currentTheme = themeNotifier.currentTheme;
        final fontProvider = Provider.of<FontProvider>(context);
        final selectedFontFamily =
            fontProvider.selectedFontFamily; // Get the FontProvider
        // This calculates the item spacing based on screen width
        final screenWidth = MediaQuery.of(context).size.width;
        // When the screen width increases the spacing between each button increases, so when the page is in full screen, the menu item buttons are more spread.
        // Calculate item spacing based on screen width
        double menuItemSpacing = screenWidth * 0.008;
        double minSpacing = 5.0;
        // This ensures that there is a minimum spacing so that the buttons do not overlap on very small screens
        menuItemSpacing = menuItemSpacing.clamp(minSpacing, double.infinity);

        // Adding the if statements depending on the theme.
        Color backgroundColor = currentTheme == ThemeNotifier.darkTheme
            ? Colors.grey[800]!
            : Colors.white;
        Color textColor = currentTheme == ThemeNotifier.darkTheme
            ? Colors.white
            : Colors.black;

        return Scaffold(
          backgroundColor: themeNotifier.currentTheme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: themeNotifier.currentTheme.scaffoldBackgroundColor,
            title: Text(
              'Settings',
              // Seting the title to settings.
              // Adding a text style to control the fontweight, family and size.
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: selectedFontFamily,
                fontSize: 30.0,
                color: themeNotifier.currentTheme.textTheme.headline6?.color,
              ),
            ),
            // added a automatcallyimplylead to remove the return icon in the top left corner.
            automaticallyImplyLeading: false,
            // Centering the title.
            centerTitle: true,
            // Set app bar background color
          ),
          body: Column(
            children: [
              // Adding a sized box within the title and the settings container.
              const SizedBox(height: 20),
              // Add spacing between app bar and settings items
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: menuItemSpacing,
                  horizontal: 16.0,
                ),
                decoration: BoxDecoration(
                  color:
                      backgroundColor, // Set container background colour to background colour based on the theme.
                  borderRadius:
                      BorderRadius.circular(15.0), // Set border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                          0.5), // Set box shadow color with opacity
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 3), // Set shadow offset
                    ),
                  ],
                ),
                child: ListTile(
                  title: Center(
                    child: Text(
                      // Creating a button called customise fonts, this will allow the user to select the button and choose a font.
                      'Customise Fonts', // Set the menu item text
                      style: TextStyle(
                        fontFamily: selectedFontFamily, // Set font family
                        // Setting the font size to 16 for now.
                        fontSize: 16.0,
                        color:
                            textColor, // Setting the text colour to text color based on the theme.
                      ),
                    ),
                  ),
                  // Show font customisation dialog
                  // Added a barrier color to make the background go dark when the dialog is opened.
                  // When the showdialog is called flutter automatically created a overlay entry which includes a model barrier,
                  // and this dims the background. So I used this line of code to increase the opacity.
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.85),
                      builder: (BuildContext context) {
                        return const FontDropdownDialog(); // Create an instance of FontDropdownDialog
                      },
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: menuItemSpacing,
                  horizontal: 16.0,
                ),
                decoration: BoxDecoration(
                  color: backgroundColor, // Set container background colour
                  borderRadius:
                      BorderRadius.circular(15.0), // Setting the border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                          0.5), // Setting the box shadow color with opacity
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 3), // Set shadow offset
                    ),
                  ],
                ),
                // Added a customise theme button that allows the users to select a theme they want so that the
                // text colour and background colours change.
                child: ListTile(
                  title: Center(
                    child: Text(
                      'Customise Theme',
                      style: TextStyle(
                        fontFamily:
                            selectedFontFamily, // Setting the font family.
                        fontSize: 16.0, // Setting the font size.
                        color: textColor, // Setting the text colour
                      ),
                    ),
                  ),
                  // Showing the customise themes dialog when they click on the button. Which presents the text in the font type and then
                  // the theme in the theme depending on what theme they chose.
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.85),
                      builder: (BuildContext context) {
                        return ThemeDropdownDialog(
                          fontProvider: fontProvider,
                          themeNotifier: themeNotifier,
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: menuItemSpacing,
                  left: 16.0,
                  right: 16.0,
                  bottom: 20.0,
                ),
                decoration: BoxDecoration(
                  color: backgroundColor, // Set background color
                  borderRadius:
                      BorderRadius.circular(15.0), // Setting the border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                          0.5), // Setting the box shadow color with opacity
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 3), // Set shadow offset
                    ),
                  ],
                ),
                child: ListTile(
                  title: Center(
                    child: Text(
                      'Logout', // Set menu logout text
                      style: TextStyle(
                        fontFamily: selectedFontFamily, // Set font family
                        fontSize: 16.0, // Set font size
                        color: textColor, // Set font size
                      ),
                    ),
                  ),
                  // Show logout dialog
                  onTap: () {
                    Color backgroundColor =
                        currentTheme == ThemeNotifier.darkTheme
                            ? Colors.grey[800]!
                            : Colors.white;
                    Color textColor = currentTheme == ThemeNotifier.darkTheme
                        ? Colors.white
                        : Colors.black;
                    LogoutDialog.show(context, selectedFontFamily,
                        backgroundColor, textColor);
                  },
                ),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: CustomBottomAppBar(
            onHomePressed: () {
              Navigator.pushNamed(context, '/home');
            },
            onSettingsPressed: () {},
          ),
        );
      },
    );
  }
}
