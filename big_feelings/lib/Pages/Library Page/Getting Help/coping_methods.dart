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

      List<String> animations = [
        "assets/animation/boywalk.json",
        "assets/animation/callafriend.json",
        "assets/animation/water.json",
        "assets/animation/boywalk.json",
        "assets/animation/boywalk.json",
        "assets/animation/boywalk.json",
        "assets/animation/boywalk.json",
        "assets/animation/boywalk.json",
        "assets/animation/boywalk.json",
        "assets/animation/boywalk.json",
        "assets/animation/boywalk.json",
        "assets/animation/boywalk.json",
      ];

      List<String> copingMethods = [
        "Go on a           Walk",
        "Call a            Friend",
        "Water coping  tricks",
        "Listen to         music",
        "Journalling",
        "Deep              Breathing",
        "Mindfulness",
        "Boy Walk",
        "Boy Walk",
        "Boy Walk",
        "Boy Walk",
        "Boy Walk",
      ];

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
            icon: Icon(
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
                        int animationIndex = rowIndex * 4 + colIndex;
                        return GestureDetector(
                          onTap: () {},
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
                                      copingMethods[animationIndex],
                                      style: fontProvider
                                          .libarytext(themeNotifier),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : OverflowBox(
                                    minHeight: 600,
                                    maxHeight: 600,
                                    child: Lottie.asset(
                                      animations[animationIndex],
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
}
