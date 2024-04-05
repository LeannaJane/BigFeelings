// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageSelector extends StatefulWidget {
  @override
  _ImageSelectorState createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  //! Variable to hold the selected image path.
  String selectedImage = 'assets/Home/penguin.png';

  //! List of image choices for the user to select.
  List<String> images = [
    'assets/Home/penguin.png',
    'assets/Home/penguin_emotion.png',
    'assets/Home/penguin_cute.png',
  ];

  //! Setting the state of what image they had previous.
  @override
  void initState() {
    super.initState();
    loadSelectedImage();
  }

  //! Method to load the image the user had previously.
  Future<void> loadSelectedImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String imagePath =
        prefs.getString('selectedImage') ?? 'assets/Home/penguin.png';
    if (!images.contains(imagePath)) {
      imagePath = images.first;
    }
    setState(() {
      selectedImage = imagePath;
    });
  }

  //! Reusing code from home page.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        Color getContainerColor = themeNotifier.getContainerColor();

        return GestureDetector(
          //! Added a dialog, reused from the color page and edited.
          onTap: () {
            _showImageSelectionDialog(
              context,
              Provider.of<FontProvider>(context, listen: false),
              Provider.of<ThemeNotifier>(
                context,
                listen: false,
              ),
              getContainerColor,
            );
          },
          child: Container(
            //! Setting the height based on the output of the size method.
            height: _checkImageSize(context),
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: getContainerColor,
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
            //! Reusing code from the home page.
            //! Displaying the default or selected image.
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(selectedImage, fit: BoxFit.cover),
            ),
          ),
        );
      },
    );
  }

  //! Image dialog.
  Future<void> _showImageSelectionDialog(
      BuildContext context,
      FontProvider fontProvider,
      ThemeNotifier themeNotifier,
      Color getContainerColor) async {
    final selectedImagePath = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //! Presenting user with text and the list of images.
          title: Text(
            'Select an Image',
            textAlign: TextAlign.center,
            style: fontProvider.subheadingBigBald(themeNotifier),
          ),
          backgroundColor: getContainerColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: images
                .map(
                  (imagePath) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(imagePath);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(imagePath, width: 100, height: 100),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
    //! If a new image is selected it will update the selected image path and save it
    if (selectedImagePath != null) {
      setState(() {
        selectedImage = selectedImagePath;
      });
      saveSelectedImage(selectedImagePath);
    }
  }

  //! A method to save the selected image and its path.
  Future<void> saveSelectedImage(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedImage', imagePath);
  }

  //! Checking the image size based on the size of the screen.
  double _checkImageSize(BuildContext context) {
    double containerSize;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    if (width > 800 && height > 1000) {
      containerSize = 500;
    } else if (width > 550 && height > 800) {
      containerSize = 350;
    } else if (width > 300 && height > 600) {
      containerSize = 200;
    } else if (width > 150 && height > 400) {
      containerSize = 150;
    } else if (height > 200) {
      containerSize = 100;
    } else {
      containerSize = 100;
    }
    //! returning the container sie based on the if media query.
    return containerSize;
  }
}
