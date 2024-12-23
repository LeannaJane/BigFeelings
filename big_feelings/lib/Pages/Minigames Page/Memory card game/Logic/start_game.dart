import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Pages/Minigames%20Page/Memory%20card%20game/Logic/color.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class StartGame extends StatefulWidget {
  const StartGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StartGameState createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {
  bool showQuiz = false;
  Color selectedColor = Colors.red;
  bool colorSelected = false;

  bool isDesktop(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return width > 550 && height > 800;
  }

  String getColorName(Color color) {
    if (color == Colors.red) {
      return 'Red';
    } else if (color == Colors.green) {
      return 'Green';
    } else if (color == Colors.blue) {
      return 'Blue';
    } else if (color == const Color.fromARGB(255, 255, 90, 145)) {
      return 'Pink';
    } else if (color == const Color.fromARGB(255, 0, 195, 255)) {
      return 'Baby Blue';
    } else {
      return 'Unknown Color';
    }
  }

  void navigateToGame(BuildContext context) {
    if (isDesktop(context)) {
      Navigator.pushNamed(context, '/memory-game-desktop',
          arguments: selectedColor);
    } else {
      Navigator.pushNamed(context, '/memory-mobile', arguments: selectedColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        final fontProvider = Provider.of<FontProvider>(context);
        Color getContainerColor =
            Provider.of<ThemeNotifier>(context).getContainerColor();
        Color iconColor = themeNotifier.getIconColor();

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Emotion Memory Game',
              style: fontProvider.getOtherTitleStyle(themeNotifier),
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30.0,
                color: iconColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      Container(
                        width: 300,
                        height: 200,
                        margin: const EdgeInsets.only(bottom: 20.0),
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
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Welcome to the emotional memory card game, where you can select emotions and match them with their pairs to test your memory and emotional recognition skills.',
                              style: fontProvider.subheading(themeNotifier),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Color? newColor = await showDialog<Color>(
                            context: context,
                            builder: (BuildContext context) {
                              return ColorDialog();
                            },
                          );

                          setState(() {
                            selectedColor = newColor ?? Colors.red;
                            colorSelected = true;
                          });
                        },
                        child: Container(
                          width: 150,
                          height: 40,
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
                          child: Center(
                            child: Text(
                                colorSelected
                                    ? getColorName(selectedColor)
                                    : 'Colour',
                                textAlign: TextAlign.center,
                                style: fontProvider.subheading(themeNotifier)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => navigateToGame(context),
                        child: Container(
                          width: 150,
                          height: 40,
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
                          child: Center(
                            child: Text(
                              'Start Game',
                              style: fontProvider.subheading(themeNotifier),
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(height: 80),
                      SizedBox(
                        height: 120,
                        child: OverflowBox(
                          minHeight: 300,
                          maxHeight: 400,
                          alignment: Alignment.topCenter,
                          //? Ref 25
                          child: Lottie.asset(
                              "assets/animation/penguindance.json"),
                        ),
                      ),
                    ],
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
