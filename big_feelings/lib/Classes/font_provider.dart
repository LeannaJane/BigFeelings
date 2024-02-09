import 'package:flutter/material.dart';

// This is a class that extends ChangeNotifer, allowing it to manage and notifer the changes on the font state.
class FontProvider with ChangeNotifier {
  String _selectedFontFamily = 'SingleDay'; // Default font family

  //Map from the settings page moved here so it doesnt need to be called everytime.
  final List<String> _supportedFontFamilies = [
    'Arial',
    'Roboto',
    'Open Sans',
    'SingleDay'
  ]; // List of supported font families

  // A getter method to retrieve the currently selected font family.
  String get selectedFontFamily => _selectedFontFamily;

  List<String> get supportedFontFamilies => _supportedFontFamilies;

  // A method to set the font family which updates the _selectedFontFamily property and notifies listeners.
  void setFontFamily(String fontFamily) {
    _selectedFontFamily = fontFamily;
    notifyListeners(); // Notify listeners when the font family changes
  }
}
