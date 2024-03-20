import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

//! This is a class that extends ChangeNotifer, allowing it to manage and notifer the changes on the font state.
class FontProvider with ChangeNotifier {
  String _selectedFontFamily = 'SingleDay'; // Default font family

  //! Map from the settings page moved here so it doesnt need to be called everytime.
  //! List of supported font families
  final List<String> _supportedFontFamilies = [
    'Pacifico',
    'Roboto Mono',
    'ShortStack',
    'SingleDay',
  ];

  String get selectedFontFamily => _selectedFontFamily;

  List<String> get supportedFontFamilies => _supportedFontFamilies;
  //! A method to set the font family which updates the _selectedFontFamily property and notifies listeners.
  Future<void> setFontFamily(String fontFamily) async {
    _selectedFontFamily = fontFamily;
    //! Notify listeners when the font family changes
    notifyListeners();
    //! This stores the selected font family in SharedPreferences so when the page refreshes the font does not return back to default.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedFontFamily', fontFamily);
  }

  Future<void> loadSelectedFontFamily() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedFontFamily = prefs.getString('selectedFontFamily');
    if (selectedFontFamily != null &&
        _supportedFontFamilies.contains(selectedFontFamily)) {
      _selectedFontFamily = selectedFontFamily;
    }
    notifyListeners();
  }

  //! This shows diff types of font styles, so each text can have different boldnesses and font sizes/colours.
  //! Regular font style.
  TextStyle getRegularFontStyle(
      {double fontSize = 16.0, required String fontFamily}) {
    switch (fontFamily) {
      case 'Pacifico':
        return GoogleFonts.pacifico(fontSize: fontSize);
      case 'Roboto Mono':
        return GoogleFonts.robotoMono(fontSize: fontSize);
      case 'ShortStack':
        return GoogleFonts.shortStack(fontSize: fontSize);
      case 'SingleDay':
        return const TextStyle(fontFamily: 'SingleDay', fontSize: 16);
      default:
        return TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
        );
    }
  }

  TextStyle getOtherTitleStyle(ThemeNotifier themeNotifier) {
    Color textColor = themeNotifier.currentTheme == ThemeNotifier.darkTheme
        ? Colors.white
        : Colors.black;
    switch (_selectedFontFamily) {
      case 'Pacifico':
        return GoogleFonts.pacifico(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: textColor,
        );
      case 'Roboto Mono':
        return GoogleFonts.robotoMono(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: textColor,
        );
      case 'ShortStack':
        return GoogleFonts.shortStack(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: textColor,
        );
      case 'SingleDay':
        return TextStyle(
          fontFamily: 'SingleDay',
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: textColor,
        );
      default:
        return TextStyle(
          fontFamily: _selectedFontFamily,
          fontSize: 25,
          color: textColor,
        );
    }
  }

  TextStyle getTitleFontStyle(ThemeNotifier themeNotifier) {
    Color textColor = themeNotifier.currentTheme == ThemeNotifier.darkTheme
        ? Colors.white
        : Colors.black;
    switch (_selectedFontFamily) {
      case 'Pacifico':
        return GoogleFonts.pacifico(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: textColor,
        );
      case 'Roboto Mono':
        return GoogleFonts.robotoMono(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: textColor,
        );
      case 'ShortStack':
        return GoogleFonts.shortStack(
            fontSize: 25, fontWeight: FontWeight.bold);
      case 'SingleDay':
        return TextStyle(
          fontFamily: 'SingleDay',
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: textColor,
        );
      default:
        return TextStyle(
          fontFamily: _selectedFontFamily,
          fontSize: 25,
          color: textColor,
        );
    }
  }

  //!  Small text for the alert dialog.
  TextStyle smalltextfontstyle({double fontSize = 18.0}) {
    switch (_selectedFontFamily) {
      case 'Pacifico':
        return GoogleFonts.pacifico();
      case 'Roboto Mono':
        return GoogleFonts.robotoMono(
          fontSize: fontSize,
        );
      case 'ShortStack':
        return GoogleFonts.shortStack(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        );
      case 'SingleDay':
        return TextStyle(
          fontFamily: 'SingleDay',
          fontSize: fontSize,
        );
      default:
        return TextStyle(
          fontFamily: _selectedFontFamily,
          fontSize: fontSize,
        );
    }
  }

  TextStyle subheading(ThemeNotifier themeNotifier) {
    Color textColor = themeNotifier.currentTheme == ThemeNotifier.darkTheme
        ? Colors.white
        : Colors.black;
    switch (_selectedFontFamily) {
      case 'Pacifico':
        return GoogleFonts.pacifico(
          fontSize: 14,
          color: textColor,
        );
      case 'Roboto Mono':
        return GoogleFonts.robotoMono(
          fontSize: 14,
          color: textColor,
        );
      case 'ShortStack':
        return GoogleFonts.shortStack(
          fontSize: 14,
          color: textColor,
        );
      case 'SingleDay':
        return TextStyle(
          fontFamily: 'SingleDay',
          fontSize: 16,
          color: textColor,
        );
      default:
        return TextStyle(
          fontFamily: _selectedFontFamily,
          fontSize: 14,
          color: textColor,
        );
    }
  }

  TextStyle subheadinglogin(ThemeNotifier themeNotifier) {
    Color textColor = themeNotifier.currentTheme == ThemeNotifier.darkTheme
        ? Colors.white
        : Colors.black;

    double fontSize = 16.0;

    switch (_selectedFontFamily) {
      case 'Pacifico':
        return GoogleFonts.pacifico(
          fontSize: fontSize,
          color: textColor,
        );
      case 'Roboto Mono':
        return GoogleFonts.robotoMono(
          fontSize: fontSize,
          color: textColor,
        );
      case 'ShortStack':
        return GoogleFonts.shortStack(
          fontSize: fontSize,
          color: textColor,
        );
      case 'SingleDay':
        return TextStyle(
          fontFamily: 'SingleDay',
          fontSize: fontSize,
          color: textColor,
        );
      default:
        return TextStyle(
          fontFamily: _selectedFontFamily,
          fontSize: 16,
          color: textColor,
        );
    }
  }

  TextStyle subheadingbald(ThemeNotifier themeNotifier) {
    Color textColor = themeNotifier.currentTheme == ThemeNotifier.darkTheme
        ? Colors.white
        : Colors.black;

    double fontSize = 16.0;

    switch (_selectedFontFamily) {
      case 'Pacifico':
        return GoogleFonts.pacifico(
          fontSize: fontSize,
          color: textColor,
        );
      case 'Roboto Mono':
        return GoogleFonts.robotoMono(
          fontSize: fontSize,
          color: textColor,
        );
      case 'ShortStack':
        return GoogleFonts.shortStack(
          fontSize: fontSize,
          color: textColor,
        );
      case 'SingleDay':
        return TextStyle(
          fontFamily: 'SingleDay',
          fontSize: fontSize,
          color: textColor,
        );
      default:
        return TextStyle(
          fontFamily: _selectedFontFamily,
          fontSize: 16,
          color: textColor,
        );
    }
  }

  TextStyle ButtonText(ThemeNotifier themeNotifier) {
    Color textColor = themeNotifier.currentTheme == ThemeNotifier.darkTheme
        ? Colors.white
        : Colors.black;

    double fontSize = 24.0;

    switch (_selectedFontFamily) {
      case 'Pacifico':
        return GoogleFonts.pacifico(
          fontSize: fontSize,
          color: textColor,
        );
      case 'Roboto Mono':
        return GoogleFonts.robotoMono(
          fontSize: fontSize,
          color: textColor,
        );
      case 'ShortStack':
        return GoogleFonts.shortStack(
          fontSize: fontSize,
          color: textColor,
        );
      case 'SingleDay':
        return TextStyle(
          fontFamily: 'SingleDay',
          fontSize: fontSize,
          color: textColor,
        );
      default:
        return TextStyle(
          fontFamily: _selectedFontFamily,
          fontSize: 16,
          color: textColor,
        );
    }
  }

  //! Adding another textstyle for a diff size font for the login and signup buttons.
  TextStyle welcomepagetext({double fontSize = 16.0}) {
    switch (_selectedFontFamily) {
      case 'Pacifico':
        return GoogleFonts.pacifico(
          fontSize: 20,
        );
      case 'Roboto Mono':
        return GoogleFonts.robotoMono(
          fontSize: fontSize,
        );
      case 'ShortStack':
        return GoogleFonts.shortStack(
            fontSize: fontSize, fontWeight: FontWeight.bold);
      case 'SingleDay':
        return const TextStyle(
          fontFamily: 'SingleDay',
          fontSize: 20,
        );
      default:
        return TextStyle(
          fontFamily: _selectedFontFamily,
          fontSize: fontSize,
        );
    }
  }

  TextStyle getSubTitleStyle({
    double fontSize = 16.0,
    required ThemeNotifier themeNotifier,
  }) {
    Color textColor = themeNotifier.currentTheme == ThemeNotifier.darkTheme
        ? Colors.white
        : Colors.black;

    switch (_selectedFontFamily) {
      case 'Pacifico':
        return GoogleFonts.pacifico(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: textColor,
        );
      case 'Roboto Mono':
        return GoogleFonts.robotoMono(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: textColor,
        );
      case 'ShortStack':
        return GoogleFonts.shortStack(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: textColor,
        );
      case 'SingleDay':
        return TextStyle(
          fontFamily: 'SingleDay',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColor,
        );
      default:
        return TextStyle(
          fontFamily: _selectedFontFamily,
          fontSize: fontSize,
          color: textColor,
        );
    }
  }

  TextStyle errortext({
    double fontSize = 16.0,
    Color textcolour = Colors.red,
  }) {
    switch (_selectedFontFamily) {
      case 'Pacifico':
        return GoogleFonts.pacifico(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: textcolour,
        );
      case 'Roboto Mono':
        return GoogleFonts.robotoMono(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: textcolour,
        );
      case 'ShortStack':
        return GoogleFonts.shortStack(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: textcolour,
        );
      case 'SingleDay':
        return TextStyle(
          fontFamily: 'SingleDay',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textcolour,
        );
      default:
        return TextStyle(
          fontFamily: _selectedFontFamily,
          fontSize: fontSize,
          color: textcolour,
        );
    }
  }

  TextStyle greentext({
    double fontSize = 16.0,
    Color textcolour = Colors.green,
  }) {
    switch (_selectedFontFamily) {
      case 'Pacifico':
        return GoogleFonts.pacifico(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: textcolour,
        );
      case 'Roboto Mono':
        return GoogleFonts.robotoMono(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: textcolour,
        );
      case 'ShortStack':
        return GoogleFonts.shortStack(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: textcolour,
        );
      case 'SingleDay':
        return TextStyle(
          fontFamily: 'SingleDay',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textcolour,
        );
      default:
        return TextStyle(
          fontFamily: _selectedFontFamily,
          fontSize: fontSize,
          color: textcolour,
        );
    }
  }

  TextStyle fontstylenotbald({
    double fontSize = 14.0,
    Color textcolour = Colors.black, // Specify the default color here
    required ThemeNotifier themeNotifier,
  }) {
    Color textColor = themeNotifier.currentTheme == ThemeNotifier.darkTheme
        ? Colors.white
        : Colors.black;

    switch (_selectedFontFamily) {
      case 'Pacifico':
        return GoogleFonts.pacifico(
          fontSize: fontSize,
          color: textcolour,
        );
      case 'Roboto Mono':
        return GoogleFonts.robotoMono(
          fontSize: fontSize,
          color: textcolour,
        );
      case 'ShortStack':
        return GoogleFonts.shortStack(
          fontSize: fontSize,
          color: textcolour,
        );
      case 'SingleDay':
        return TextStyle(
          fontFamily: 'SingleDay',
          fontSize: fontSize,
          color: textColor,
        );
      default:
        return TextStyle(
          fontFamily: _selectedFontFamily,
          fontSize: fontSize,
          color: textColor,
        );
    }
  }

  TextStyle calenderText({
    double fontSize = 18.0,
    Color textcolour = Colors.black,
    required ThemeNotifier themeNotifier,
  }) {
    Color textColor = themeNotifier.currentTheme == ThemeNotifier.darkTheme
        ? Colors.white
        : Colors.black;

    switch (_selectedFontFamily) {
      case 'Pacifico':
        return GoogleFonts.pacifico(
          fontSize: fontSize,
          color: textcolour,
        );
      case 'Roboto Mono':
        return GoogleFonts.robotoMono(
          fontSize: fontSize,
          color: textcolour,
        );
      case 'ShortStack':
        return GoogleFonts.shortStack(
          fontSize: fontSize,
          color: textcolour,
        );
      case 'SingleDay':
        return TextStyle(
          fontFamily: 'SingleDay',
          fontSize: fontSize,
          color: textColor,
        );
      default:
        return TextStyle(
          fontFamily: _selectedFontFamily,
          fontSize: fontSize,
          color: textColor,
        );
    }
  }
}
