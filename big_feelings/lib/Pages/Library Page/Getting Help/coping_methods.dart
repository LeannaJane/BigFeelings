// ignore_for_file: library_private_types_in_public_api, use_super_parameters

import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CopingMethods extends StatefulWidget {
  const CopingMethods({Key? key}) : super(key: key);

  @override
  _CopingMethodsState createState() => _CopingMethodsState();
}

class _CopingMethodsState extends State<CopingMethods> {
  bool _isPaused = false;

  List<String> copingMethods = [
    "Go on a Walk",
    "Call a Friend",
    "Listen to music",
    "Journalling",
    "Deep Breathing",
    "Meditation",
    "Activites",
    "Playing with a pet",
    "Splash water trick",
    "Hold a icecube",
    "Ask for help",
    "Self Talk",
  ];

  Map<String, String> copingMethodsWithImages = {
    "Go on a Walk": 'assets/images/coping_skills/walking.png',
    "Call a Friend": 'assets/images/coping_skills/phonecall.png',
    "Listen to music": 'assets/images/coping_skills/headphones.png',
    "Journalling": 'assets/images/coping_skills/journal.png',
    "Deep Breathing": 'assets/images/coping_skills/breathing.png',
    "Meditation": 'assets/images/coping_skills/meditation.png',
    "Activites": 'assets/images/coping_skills/painting.png',
    "Playing with a pet": 'assets/images/coping_skills/pets.png',
    "Splash water trick": 'assets/images/coping_skills/splashwater.png',
    "Hold a icecube": 'assets/images/coping_skills/ice.png',
    "Ask for help": 'assets/images/coping_skills/help.png',
    "Self Talk": 'assets/images/coping_skills/selftalk.png',
  };

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final getContainerColor =
          Provider.of<ThemeNotifier>(context).getContainerColor();
      Color iconColor = themeNotifier.getIconColor();
      final fontProvider = Provider.of<FontProvider>(context);

      final screenWidth = MediaQuery.of(context).size.width;
      final containerWidth = (screenWidth - 48) / 4;
      const containerHeight = 150.0;

      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Coping Mechanisms',
            style: fontProvider.getOtherTitleStyle(themeNotifier),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (rowIndex) => Column(
                    children: List.generate(
                      4,
                      (colIndex) {
                        int index = rowIndex * 4 + colIndex;
                        return GestureDetector(
                          onTap: () {
                            _showCopingMethodDialog(
                                context, index, fontProvider, themeNotifier);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 8.0,
                            ),
                            width: containerWidth < containerHeight
                                ? containerWidth
                                : containerHeight,
                            height: containerWidth < containerHeight
                                ? containerWidth
                                : containerHeight,
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
                            child: _isPaused
                                ? Center(
                                    child: Text(
                                      copingMethods[index],
                                      style: fontProvider
                                          .libarytext(themeNotifier),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : OverflowBox(
                                    child: Transform.scale(
                                      scale:
                                          0.5, // Adjust scale factor as needed
                                      child: Image.asset(
                                        copingMethodsWithImages[
                                                copingMethods[index]] ??
                                            '',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _togglePause,
          tooltip: _isPaused ? 'Play' : 'Pause',
          backgroundColor: getContainerColor,
          child: Icon(
            _isPaused ? Icons.play_arrow : Icons.pause,
            color: iconColor,
          ),
        ),
      );
    });
  }

  void _showCopingMethodDialog(BuildContext context, int index,
      FontProvider fontProvider, ThemeNotifier themeNotifier) {
    String copingMethod = copingMethods[index];
    String imagePath =
        copingMethodsWithImages[copingMethod] ?? ''; // Retrieve image path
    TextStyle textStyle = fontProvider.libarytext(themeNotifier);
    TextStyle greenTextStyle = textStyle.copyWith(color: Colors.green);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor:
              Provider.of<ThemeNotifier>(context).getContainerColor(),
          child: SizedBox(
            width: 300.0,
            height: 300.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Coping Method',
                    style: textStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    copingMethod,
                    style: textStyle,
                  ),
                ),
                const SizedBox(height: 10.0),
                Image.asset(
                  imagePath,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 10.0),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Close',
                        style: greenTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
