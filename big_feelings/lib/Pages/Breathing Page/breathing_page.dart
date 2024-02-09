import 'dart:async';
import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Pages/Breathing%20Page/pulsating_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BreathingPage extends StatefulWidget {
  const BreathingPage({Key? key}) : super(key: key);

  @override
  _BreathingPageState createState() => _BreathingPageState();
}

class _BreathingPageState extends State<BreathingPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _timer;
  bool _isBreathing = false;
  bool _isAnimating = false;
  Color? selectedColour;
  bool inhale = true;

  final Duration cycleDuration = const Duration(seconds: 4);

  List<Color> availableColours = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.blueGrey,
    const Color.fromARGB(255, 44, 27, 2),
    const Color.fromARGB(255, 255, 160, 19),
  ];

  final Map<Color, String> colorNames = {
    Colors.blue: 'Blue',
    Colors.red: 'Red',
    Colors.green: 'Green',
    Colors.blueGrey: 'Grey',
    const Color.fromARGB(255, 44, 27, 2): 'Brown',
    const Color.fromARGB(255, 255, 160, 19): 'Orange',
  };

  String colourName(Color colour) {
    return colorNames[colour] ?? 'Unknown';
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: cycleDuration,
    );
    selectedColour = null;
    inhale = true;
  }

  void _startPulsatingAnimation() {
    if (_isAnimating) {
      _controller.stop();
      _timer?.cancel();
    } else {
      _controller.repeat(reverse: true);
      _timer = Timer.periodic(cycleDuration, (timer) {
        setState(() {
          inhale = !inhale;
        });
      });
    }
    setState(() {
      _isBreathing = !_isAnimating;
    });
    _isAnimating = !_isAnimating;
  }

  void _showPopupMenu(Color backgroundColor) async {
    final RenderBox button = context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(button.size.bottomRight(Offset.zero)),
        button.localToGlobal(button.size.bottomRight(Offset.zero)),
      ),
      Offset.zero & MediaQuery.of(context).size,
    );

    final Color? selectedColor = await showMenu<Color?>(
      context: context,
      position: position,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      items: availableColours.map<PopupMenuEntry<Color?>>((Color colour) {
        double luminance = colour.computeLuminance();
        Color textColor = luminance > 0.5 ? Colors.black : Colors.white;
        return PopupMenuItem<Color?>(
          value: colour,
          child: Container(
            decoration: BoxDecoration(
              color: colour,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: Text(
              colourName(colour),
              style: TextStyle(
                color: textColor,
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );

    if (selectedColor != null) {
      setState(() {
        selectedColour = selectedColor;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final currentTheme = themeNotifier.currentTheme;
      final fontProvider = Provider.of<FontProvider>(context);
      final selectedFontFamily = fontProvider.selectedFontFamily;

      Color backgroundColor = currentTheme == ThemeNotifier.darkTheme
          ? Colors.grey[800]!
          : Colors.white;
      Color textColor =
          currentTheme == ThemeNotifier.darkTheme ? Colors.white : Colors.black;

      Color iconColor =
          currentTheme == ThemeNotifier.darkTheme ? Colors.white : Colors.black;

      return Scaffold(
        backgroundColor: themeNotifier.currentTheme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: themeNotifier.currentTheme.scaffoldBackgroundColor,
          title: Text(
            'Breathing Exercise',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: selectedFontFamily,
              fontSize: 30.0,
              color: textColor,
            ),
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
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200.0,
                    height: 200.0,
                    child: Hero(
                      tag: 'breathing_1',
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return CustomPaint(
                            painter: PulsatingCirclesPainter(
                              _controller,
                              selectedColour ?? Colors.blue,
                              inhale,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 45.0),
                  ElevatedButton(
                    onPressed: _startPulsatingAnimation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: backgroundColor,
                      elevation: 5,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      _isBreathing ? 'Stop Breathing' : 'Start Breathing',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
            Positioned(
              bottom: 10.0,
              right: 8.0,
              child: ElevatedButton(
                onPressed: () => _showPopupMenu(backgroundColor),
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  elevation: 5,
                  shadowColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 10.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      selectedColour == null
                          ? 'Colour'
                          : colourName(selectedColour!),
                      style: TextStyle(
                        color: textColor,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 25.0),
                    Icon(Icons.arrow_drop_down, color: iconColor),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
