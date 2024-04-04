import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Pages/Mental%20Health%20Page/Breathing%20Page/pulsating_animation.dart';

/* 
! References
* This Flutter code for a pulsating animation was developed with guidance from the community on Stack Overflow.
* It was inspired by and adapted from solutions provided in the following Stack Overflow thread:
* Reference Stack Overflow. (n.d.). Flutter - I am looking for a way to do a pulse animation. [online] Available at: https://stackoverflow.com/questions/50739048/flutter-i-am-looking-for-a-way-to-do-a-pulse-animation.
*/

//! Defining the breathing page widget as a stateful widget.
class BreathingPage extends StatefulWidget {
  // ignore: use_super_parameters
  const BreathingPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BreathingPageState createState() => _BreathingPageState();
}

//! Defining the state for the breathing page widget.
class _BreathingPageState extends State<BreathingPage>
    with SingleTickerProviderStateMixin {
  //! Creating an animation controller for the breathing animation.
  late final AnimationController _controller;
  Timer? _timer;
  //! Flags to track whether breathing is happening and whether the animation is moving in or out.
  bool _isBreathing = false;
  // ignore: unused_field
  bool _isAnimating = false;
  //! Deciding on the color based on the selected colour chosen by the user.
  Color? selectedColour;
  //! Bool to check if inhale is true.
  bool inhale = true;

  //! Duration of the breathing cycle in and out. 4 secs in, 4 secs out.
  final Duration cycleDuration = const Duration(seconds: 4);

  late int _secondsElapsed = 0;
  late Timer _timerHandler = Timer(Duration.zero, () {});

  //! The list of available colours for the pulsating animation.

  List<Color> availableColours = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.blueGrey,
    const Color.fromARGB(255, 44, 27, 2),
    const Color.fromARGB(255, 255, 160, 19),
  ];
  //! Map of colour names for display
  final Map<Color, String> colorNames = {
    Colors.blue: 'Blue',
    Colors.red: 'Red',
    Colors.green: 'Green',
    Colors.blueGrey: 'Grey',
    const Color.fromARGB(255, 44, 27, 2): 'Brown',
    const Color.fromARGB(255, 255, 160, 19): 'Orange',
  };

  //! If colour name is unknown then it will be outputted as unknown.
  String colourName(Color colour) {
    return colorNames[colour] ?? 'Unknown';
  }

  // ignore: unused_field
  String? _currentMessage;
  @override
  void initState() {
    super.initState();
    //! Initialising animation controller
    _controller = AnimationController(
      vsync: this,
      duration: cycleDuration,
    );
    selectedColour = null;
    inhale = true;
  }

  void _startTimer() {
    _timerHandler = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
        if (_secondsElapsed == 60) {
          _currentMessage = 'You have reached 1 minute!';
        } else if (_secondsElapsed == 120) {
          _currentMessage = 'You have reached 2 minutes!';
        } else if (_secondsElapsed == 180) {
          _currentMessage = 'You have reached 3 minutes!';
        }
      });
    });
  }

  void _startPulsatingAnimation() {
    if (_isBreathing) {
      //!Reset the an imation
      _controller.stop();
      _controller.reset();
      _timer?.cancel();
      _timerHandler.cancel();
      setState(() {
        _isBreathing = false;
        _isAnimating = false;
        _secondsElapsed = 0;
        //! Reset inhale to default
        inhale = true;
        _currentMessage = null;
      });
    } else {
      //! Start the animation
      double remainingDuration = cycleDuration.inSeconds -
          (_controller.value * cycleDuration.inSeconds).floorToDouble();
      if (inhale) {
        _timer = Timer(Duration(seconds: remainingDuration.toInt()), () {
          setState(() {
            inhale = false;
          });
          _timer = Timer.periodic(cycleDuration, (timer) {
            setState(() {
              inhale = !inhale;
            });
          });
        });
      } else {
        _timer = Timer(Duration(seconds: remainingDuration.toInt()), () {
          setState(() {
            inhale = true;
          });
          _timer = Timer.periodic(cycleDuration, (timer) {
            setState(() {
              inhale = !inhale;
            });
          });
        });
      }
      _controller.repeat(reverse: inhale);
      _startTimer();
      setState(() {
        _isBreathing = true;
        _isAnimating = true;
      });
    }
  }

  //! Function to show color selection popup menu-- reused the code from the other dialog on the card minigame.
  void _showPopupMenu(Color backgroundColor, FontProvider fontProvider,
      ThemeNotifier themeNotifier) async {
    Color getContainerColor = themeNotifier.getContainerColor();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Material(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: getContainerColor,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    'Select a Colour',
                    textAlign: TextAlign.center,
                    style: fontProvider.subheadingBigBald(themeNotifier),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(availableColours.length, (index) {
                    final color = availableColours[index];
                    final colorName = colourName(color);
                    double luminance = color.computeLuminance();
                    //! Text colour set based on the theme.
                    Color textColor =
                        luminance > 0.5 ? Colors.black : Colors.white;
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(color);
                        setState(() {
                          selectedColour = color;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            width: 200,
                            height: 50,
                            child: Center(
                              child: Center(
                                child: Text(
                                  colorName,
                                  style: fontProvider
                                      .smalltextalert(themeNotifier)
                                      .copyWith(
                                        color: textColor,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }

  //! Dispose method to clean up resources when the widget is disposed
  @override
  void dispose() {
    //! Dispose of the animation controller
    _controller.dispose();
    //! Cancel the timer if it is active
    _timer?.cancel();
    //! Cancel the timer handler
    _timerHandler.cancel();
    //! Call the superclass dispose method
    super.dispose();
  }

  //! Build method to create the UI for the BreathingPage
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final fontProvider = Provider.of<FontProvider>(context);
      Color getContainerColor =
          Provider.of<ThemeNotifier>(context).getContainerColor();
      Color iconColor = themeNotifier.getIconColor();
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Calm Breathing',
            style: fontProvider.getOtherTitleStyle(themeNotifier),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          //! automaticallyImplyLeading set to true to remove return button.
          automaticallyImplyLeading: false,
          //! Creating a return icon button with the selected iconcolour and size.
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30.0,
              color: iconColor,
            ),
            onPressed: () {
              //! If selected it will return to the previous page.
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          //! Center widget to horizontally and vertically center its child

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 150),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 40.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    'Timer: ${(_secondsElapsed ~/ 60).toString().padLeft(2, '0')}:${(_secondsElapsed % 60).toString().padLeft(2, '0')}',
                    style: fontProvider.subheadingBig(themeNotifier),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                //! Container with a pulsating animation
                SizedBox(
                  width: 200.0,
                  height: 200.0,
                  child: Hero(
                    tag: 'breathing_1',
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        //! Custom painter for pulsating circles animation
                        return CustomPaint(
                          painter: PulsatingCirclesPainter(
                              _controller,
                              //! Default colour.
                              selectedColour ?? Colors.grey,
                              //! Default set to inhale.
                              inhale,
                              fontProvider),
                        );
                      },
                    ),
                  ),
                ),
                //! Changed elevated buttons to containers.
                const SizedBox(height: 20),
                if (_currentMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      _currentMessage!,
                      style: fontProvider.greentext(),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: _startPulsatingAnimation,
                  child: Container(
                    width: 130,
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
                        _isBreathing ? 'Reset' : 'Start',
                        style: fontProvider.subheadingBig(themeNotifier),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _showPopupMenu(
                      getContainerColor, fontProvider, themeNotifier),
                  child: Container(
                    width: 130,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          selectedColour == null
                              ? 'Colour'
                              : colourName(selectedColour!),
                          style: fontProvider.subheadingBig(themeNotifier),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
