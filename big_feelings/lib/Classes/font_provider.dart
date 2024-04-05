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
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textColor,
        );
      case 'Roboto Mono':
        return GoogleFonts.robotoMono(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textColor,
        );
      case 'ShortStack':
        return GoogleFonts.shortStack(
          fontSize: 20,
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
  TextStyle smalltextfontstyle1() {
    double fontSize = 14.0;
    switch (_selectedFontFamily) {
      case 'Pacifico':
        return GoogleFonts.pacifico(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        );

      case 'Roboto Mono':
        return GoogleFonts.robotoMono(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        );
      case 'ShortStack':
        return GoogleFonts.shortStack(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        );
      case 'SingleDay':
        return const TextStyle(
          fontFamily: 'SingleDay',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        );
      default:
        return TextStyle(
          fontFamily: _selectedFontFamily,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        );
    }
  }

  TextStyle breathingtext() {
    double fontSize = 14.0;

    Color textColor = Colors.white;

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
          fontSize: 20,
          color: textColor,
        );
      default:
        return TextStyle(
          fontFamily: _selectedFontFamily,
          fontSize: 18,
          color: textColor,
        );
    }
  }

  //!  Small text for the alert dialog.
  TextStyle smalltextfontstyle(ThemeNotifier themeNotifier) {
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
          fontSize: 18,
          color: textColor,
        );
      default:
        return TextStyle(
          fontFamily: _selectedFontFamily,
          fontSize: fontSize,
          color: textColor,
          fontWeight: FontWeight.bold,
        );
    }
  }

  //! 14 size not bald
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

  TextStyle subheadingbold(ThemeNotifier themeNotifier) {
    Color textColor = themeNotifier.currentTheme == ThemeNotifier.darkTheme
        ? Colors.white
        : Colors.black;
    switch (_selectedFontFamily) {
      case 'Pacifico':
        return GoogleFonts.pacifico(
          fontSize: 14,
          color: textColor,
          fontWeight: FontWeight.bold,
        );
      case 'Roboto Mono':
        return GoogleFonts.robotoMono(
          fontSize: 14,
          color: textColor,
          fontWeight: FontWeight.bold,
        );
      case 'ShortStack':
        return GoogleFonts.shortStack(
          fontSize: 14,
          color: textColor,
          fontWeight: FontWeight.bold,
        );
      case 'SingleDay':
        return TextStyle(
          fontFamily: 'SingleDay',
          fontSize: 18,
          color: textColor,
          fontWeight: FontWeight.bold,
        );
      default:
        return TextStyle(
          fontFamily: _selectedFontFamily,
          fontSize: 14,
          color: textColor,
          fontWeight: FontWeight.bold,
        );
    }
  }

  //! 16 size not bald.
  TextStyle subheadinglogin(ThemeNotifier themeNotifier) {
    Color textColor = themeNotifier.currentTheme == ThemeNotifier.darkTheme
        ? Colors.white
        : Colors.black;

    double fontSize = 14.0;

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
          fontSize: 18,
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

  TextStyle desktoplogin(ThemeNotifier themeNotifier) {
    Color textColor = themeNotifier.currentTheme == ThemeNotifier.darkTheme
        ? Colors.white
        : Colors.black;

    double fontSize = 18.0;

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

  //! 18 size text not bald.
  TextStyle subheadingBig(ThemeNotifier themeNotifier) {
    Color textColor = themeNotifier.currentTheme == ThemeNotifier.darkTheme
        ? Colors.white
        : Colors.black;

    double fontSize = 18.0;

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
          fontSize: 18,
          color: textColor,
        );
    }
  }

  //! Button text.
  TextStyle buttonText(ThemeNotifier themeNotifier) {
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

  //! 16 font size, bold.
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
          fontSize: 20,
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

  //! For the login UI and error messages for the application.
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

  //! For the Login UI and error messages.
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

  //? Calender fonts.
  //! Calender Text
  TextStyle fontstylenotbald({
    double fontSize = 14.0,
    required ThemeNotifier themeNotifier,
  }) {
    Color textColor = themeNotifier.currentTheme == ThemeNotifier.darkTheme
        ? Colors.white
        : Colors.black;

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
          fontSize: fontSize,
          color: textColor,
        );
    }
  }

  //! Used for the calender
  TextStyle calenderText({
    double fontSize = 18.0,
    required ThemeNotifier themeNotifier,
  }) {
    Color textColor = themeNotifier.currentTheme == ThemeNotifier.darkTheme
        ? Colors.white
        : Colors.black;

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
          fontSize: fontSize,
          color: textColor,
        );
    }
  }

  TextStyle quiztextquestion(ThemeNotifier themeNotifier) {
    Color textColor = themeNotifier.currentTheme == ThemeNotifier.darkTheme
        ? Colors.white
        : Colors.black;

    switch (_selectedFontFamily) {
      case 'Pacifico':
        return GoogleFonts.pacifico(
          fontSize: 15,
          color: textColor,
        );
      case 'Roboto Mono':
        return GoogleFonts.robotoMono(
          fontSize: 15,
          color: textColor,
        );
      case 'ShortStack':
        return GoogleFonts.shortStack(
          fontSize: 15,
          color: textColor,
        );
      case 'SingleDay':
        return TextStyle(
          fontFamily: 'SingleDay',
          fontSize: 19,
          color: textColor,
        );
      default:
        return TextStyle(
          fontFamily: _selectedFontFamily,
          fontSize: 19,
          color: textColor,
        );
    }
  }

  TextStyle quiztext(ThemeNotifier themeNotifier) {
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
          fontSize: 18,
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

  TextStyle libarytext(ThemeNotifier themeNotifier) {
    Color textColor = themeNotifier.currentTheme == ThemeNotifier.darkTheme
        ? Colors.white
        : Colors.black;

    switch (_selectedFontFamily) {
      case 'Pacifico':
        return GoogleFonts.pacifico(
          fontSize: 12,
          color: textColor,
        );
      case 'Roboto Mono':
        return GoogleFonts.robotoMono(
          fontSize: 12,
          color: textColor,
        );
      case 'ShortStack':
        return GoogleFonts.shortStack(
          fontSize: 12,
          color: textColor,
        );
      case 'SingleDay':
        return TextStyle(
          fontFamily: 'SingleDay',
          fontSize: 14,
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

  TextStyle description(ThemeNotifier themeNotifier) {
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
          fontSize: 16,
          color: textColor,
        );
    }
  }

  TextStyle subheadingBigBald(ThemeNotifier themeNotifier) {
    Color textColor = themeNotifier.currentTheme == ThemeNotifier.darkTheme
        ? Colors.white
        : Colors.black;

    double fontSize = 18.0;

    switch (_selectedFontFamily) {
      case 'Pacifico':
        return GoogleFonts.pacifico(
          fontSize: fontSize,
          color: textColor,
          fontWeight: FontWeight.bold,
        );
      case 'Roboto Mono':
        return GoogleFonts.robotoMono(
          fontSize: fontSize,
          color: textColor,
          fontWeight: FontWeight.bold,
        );
      case 'ShortStack':
        return GoogleFonts.shortStack(
          fontSize: fontSize,
          color: textColor,
          fontWeight: FontWeight.bold,
        );
      case 'SingleDay':
        return TextStyle(
          fontFamily: 'SingleDay',
          fontSize: 22,
          color: textColor,
          fontWeight: FontWeight.bold,
        );
      default:
        return TextStyle(
          fontFamily: _selectedFontFamily,
          fontSize: 22,
          color: textColor,
          fontWeight: FontWeight.bold,
        );
    }
  }

  TextStyle smalltextalert(ThemeNotifier themeNotifier) {
    Color textColor = Colors.white;
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
        );
      case 'SingleDay':
        return TextStyle(
          fontFamily: 'SingleDay',
          fontSize: 18,
          color: textColor,
        );
      default:
        return TextStyle(
          fontFamily: _selectedFontFamily,
          fontSize: 18,
          color: textColor,
        );
    }
  }

  TextStyle errormessages(ThemeNotifier themeNotifier) {
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
          fontSize: 22,
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
}
