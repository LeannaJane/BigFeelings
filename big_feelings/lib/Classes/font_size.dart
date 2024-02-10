import 'package:flutter/material.dart';

class FontSizeProvider with ChangeNotifier {
  //! Default font size
  double _selectedFontSize = 16.0;

  //! A getter method to retrieve the currently selected font size.
  double get selectedFontSize => _selectedFontSize;

  //! A method to set the font size which updates the _selectedFontSize property and notifies listeners.
  void setFontSize(double fontSize) {
    _selectedFontSize = fontSize;
    //! Notify listeners when the font size changes
    notifyListeners();
  }
}
