import 'package:big_feelings/Classes/bottom_app_bar.dart.dart';
import 'package:big_feelings/Pages/Settings%20Page/delete_account.dart';
import 'package:big_feelings/Pages/Settings%20Page/delete_buffer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Pages/Settings%20Page/font_dialog.dart';
import 'package:big_feelings/Pages/Settings%20Page/logout_dialog.dart';
import 'package:big_feelings/Pages/Settings%20Page/theme_dialog.dart';

class SettingsPage extends StatefulWidget {
  // ignore: use_super_parameters
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  //! Adding the same menu spacing I used in the home page.
  double menuItemSpacing = 10.0;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        final fontProvider = Provider.of<FontProvider>(context);
        Color getContainerColor =
            Provider.of<ThemeNotifier>(context).getContainerColor();
        return Scaffold(
          backgroundColor: themeNotifier.currentTheme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: themeNotifier.currentTheme.scaffoldBackgroundColor,
            title: Text(
              'Settings',
              //! Seting the title to settings.
              //! Adding a text style to control the fontweight, family and size.
              style: fontProvider.getOtherTitleStyle(themeNotifier),
            ),
            //! added a automatcallyimplylead to remove the return icon in the top left corner.
            automaticallyImplyLeading: false,
            //! Centering the title.
            centerTitle: true,
            //! Set app bar background color
          ),
          body: Column(
            children: [
              //! Adding a sized box within the title and the settings container.
              const SizedBox(height: 20),
              //! Add spacing between app bar and settings items
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: menuItemSpacing,
                  horizontal: 16.0,
                ),
                decoration: BoxDecoration(
                  color:
                      //! Set container background colour to background colour based on the theme.
                      getContainerColor,
                  borderRadius:
                      //! Set border radius
                      BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                          //! Set box shadow color with opacity
                          0.5),
                      spreadRadius: 1,
                      blurRadius: 6,
                      //! Set shadow offset
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Center(
                    child: Text(
                      //! Creating a button called customise fonts, this will allow the user to select the button and choose a font.
                      'Customise Fonts',
                      style: fontProvider.subheadinglogin(themeNotifier),
                    ),
                  ),
                  //! Show font customisation dialog
                  //! Added a barrier color to make the background go dark when the dialog is opened.
                  //! When the showdialog is called flutter automatically created a overlay entry which includes a model barrier,
                  //! and this dims the background. So I used this line of code to increase the opacity.
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.85),
                      builder: (BuildContext context) {
                        //! Create an instance of FontDropdownDialog
                        return const FontDropdownDialog();
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
                  //! Set container background colour
                  color: getContainerColor,
                  borderRadius:
                      //! Setting the border radius
                      BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      //! Setting the box shadow color with opacity
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 6,
                      //! Set shadow offset
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                //! Added a customise theme button that allows the users to select a theme they want so that the
                //! text colour and background colours change.
                child: ListTile(
                  title: Center(
                    child: Text(
                      'Customise Theme',
                      style: fontProvider.subheadinglogin(themeNotifier),
                    ),
                  ),
                  //! Showing the customise themes dialog when they click on the button. Which presents the text in the font type and then
                  //! the theme in the theme depending on what theme they chose.
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
              //! Added a delete account container by reusing and editing previous code.
              Container(
                margin: EdgeInsets.only(
                  top: menuItemSpacing,
                  left: 16.0,
                  right: 16.0,
                  bottom: menuItemSpacing,
                ),
                decoration: BoxDecoration(
                  //! Set background colour
                  color: getContainerColor,
                  borderRadius:
                      //! Setting the border radius
                      BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                          //! Setting the box shadow color with opacity
                          0.5),
                      spreadRadius: 1,
                      blurRadius: 6,
                      //! Set shadow offset
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Center(
                    child: Text(
                      //! Set menu logout text
                      'Delete Account',
                      style: fontProvider.subheadinglogin(themeNotifier),
                    ),
                  ),
                  // Show logout dialog
                  onTap: () {
                    DeleteAccountDialog.show(
                      context,
                      themeNotifier,
                      fontProvider,
                      onSuccess: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DeletingBufferingPage()));
                      },
                    );
                  },
                ),
              ),
              //! Moved the logout button to the bottom.
              Container(
                margin: EdgeInsets.only(
                  top: menuItemSpacing,
                  left: 16.0,
                  right: 16.0,
                  bottom: menuItemSpacing,
                ),
                decoration: BoxDecoration(
                  //! Set background colour
                  color: getContainerColor,
                  borderRadius:
                      //! Setting the border radius
                      BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                          //! Setting the box shadow color with opacity
                          0.5),
                      spreadRadius: 1,
                      blurRadius: 6,
                      //! Set shadow offset
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Center(
                    child: Text(
                      //! Set menu logout text
                      'Logout',
                      style: fontProvider.subheadinglogin(themeNotifier),
                    ),
                  ),
                  // Show logout dialog
                  onTap: () {
                    LogoutDialog.show(context, themeNotifier, fontProvider);
                  },
                ),
              ),
            ],
          ),
          //! Presenting the floating bottom app bar at the bottom of the page and setting the navigation for the home page.
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
