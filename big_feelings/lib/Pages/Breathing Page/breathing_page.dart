import 'dart:async';
import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Pages/Breathing%20Page/pulsating_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  bool _isAnimating = false;
  //! Deciding on the color based on the selected colour chosen by the user.
  Color? selectedColour;
  //! Bool to check if inhale is true.
  bool inhale = true;

  //! Duration of the breathing cycle in and out. 4 secs in, 4 secs out.
  final Duration cycleDuration = const Duration(seconds: 4);

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

  //! Function to start or stop the pulsating animation
  void _startPulsatingAnimation() {
    if (_isAnimating) {
      //! If animation is active, stop it
      _controller.stop();
      _timer?.cancel();
    } else {
      //! If animation is not active, start it
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

  //! Function to show color selection popup menu
  void _showPopupMenu(Color backgroundColor, FontProvider fontProvider) async {
    final selectedFontFamily = fontProvider.selectedFontFamily;
    //! Finds the render box of the button that triggers the popup
    final RenderBox button = context.findRenderObject() as RenderBox;
    //! Calculate the position of the popup relative to the button
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(button.size.bottomRight(Offset.zero)),
        button.localToGlobal(button.size.bottomRight(Offset.zero)),
      ),
      Offset.zero & MediaQuery.of(context).size,
    );
    //! Show the color selection popup menu
    final Color? selectedColor = await showMenu<Color?>(
      context: context,
      position: position,
      //! Initialised the background colour behind the colour selection items to the the theme type.
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      //! Map available colors to menu items
      items: availableColours.map<PopupMenuEntry<Color?>>((Color colour) {
        double luminance = colour.computeLuminance();
        //! Text colour set based on the theme.
        Color textColor = luminance > 0.5 ? Colors.black : Colors.white;
        //! The actual menu item colour is set behind the text of the colours.
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
                  //! Setting the text colour to textcolour and the font to 13.
                  color: textColor,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: selectedFontFamily),
            ),
          ),
        );
      }).toList(),
    );
    //! Update the selected color if a coloUr is chosen from the popup menu
    if (selectedColor != null) {
      setState(() {
        selectedColour = selectedColor;
      });
    }
  }

  //! Dispose method to clean up resources when the widget is disposed
  @override
  void dispose() {
    //! Dispose of the animation controller
    _controller.dispose();
    //! Cancel the timer if it is active
    _timer?.cancel();
    //! Call the superclass dispose method
    super.dispose();
  }

  //! Build method to create the UI for the BreathingPage
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      //! Using the Provider package to manage theme and font data
      //! Extracting theme and font information from providers
      final currentTheme = themeNotifier.currentTheme;
      final fontProvider = Provider.of<FontProvider>(context);
      final selectedFontFamily = fontProvider.selectedFontFamily;
      //! Determining background,text colors and icon colours based on theme - if dark theme, the text will be white and grey background, if light it will be white background and white text.
      Color backgroundColor = currentTheme == ThemeNotifier.darkTheme
          ? Colors.grey[800]!
          : Colors.white;
      Color textColor =
          currentTheme == ThemeNotifier.darkTheme ? Colors.white : Colors.black;
      Color iconColor =
          currentTheme == ThemeNotifier.darkTheme ? Colors.white : Colors.black;

      return Scaffold(
        //! Setting the current theme as the background colour.
        backgroundColor: themeNotifier.currentTheme.scaffoldBackgroundColor,
        appBar: AppBar(
          //! Setting the current theme as the background colour.
          backgroundColor: themeNotifier.currentTheme.scaffoldBackgroundColor,
          title: Text(
            //! Page title, centered with a trasnparent appbar. This has been assigned with the textcolour and the selectedFontFamily.
            'Breathing Exercise',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: selectedFontFamily,
              fontSize: 30.0,
              color: textColor,
            ),
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
        body: Stack(
          children: [
            //! Center widget to horizontally and vertically center its child
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  const SizedBox(height: 45.0),
                  //! Button to start/stop the pulsating animation
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
                          fontFamily: selectedFontFamily),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
            //! Positioned button at the bottom right to show color selection menu
            Positioned(
              bottom: 10.0,
              right: 8.0,
              child: ElevatedButton(
                onPressed: () => _showPopupMenu(backgroundColor, fontProvider),
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
                    //! Display selected Colour
                    Text(
                      selectedColour == null
                          ? 'Colour'
                          : colourName(selectedColour!),
                      //! Applying the text colour
                      style: TextStyle(
                          color: textColor,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: selectedFontFamily),
                    ),
                    //! Adding a drop down icon with a sized box between the text and icon.
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
