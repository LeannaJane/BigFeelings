import 'dart:math';
import 'package:big_feelings/Classes/font_provider.dart';
import 'package:flutter/material.dart';

//? Ref 52
//! A class that contains the circles for the pulsating animation, there are many variables, e.g. the animation, the font
//! provider, a bool to check whether the animation is the inhale stage.

class PulsatingCirclesPainter extends CustomPainter {
  //! Animation controller
  final Animation<double> _animation;
  //! Animation controller chosen based on the user choice.
  final Color _selectedColor;
  //! A bool to see which phase the pulsating is.
  final bool _inhale;
  //! Font provider
  final FontProvider _fontProvider;

  PulsatingCirclesPainter(
    this._animation,
    this._selectedColor,
    this._inhale,
    this._fontProvider,
  ) : super(repaint: _animation);
  //! This is a method thaat draws the pulsating circle on the canvas, and all the different circles will have

  //! different transparcys, and below also is presented the different colours.
  void drawPulsatingCircle(Canvas canvas, double value, Size size) {
    //! This calculates the opacity based on animation value
    double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    //! So all the different circles have different shades of the colour chosen.
    //! This creates the colour based on the opacity.
    Color color = Color.fromRGBO(
      _selectedColor.red,
      _selectedColor.green,
      _selectedColor.blue,
      opacity,
    );

    //! These calculations work out the circle size, area, and radius
    //! double circleSize = size.width / 2;
    double circleSize = 1.5 * size.width / 2;
    double area = circleSize * circleSize;
    double radius = sqrt(area * value / 4);
//! This defines the paint settings for the circle
    final Paint paint = Paint()..color = color;

    //! The canvas then draws a circle.
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paint);

    //! A textpan with the correct font textstyle.

    //! This creates a text span with 'Inhale' or 'Exhale' text
    final textSpan = TextSpan(
      text: _inhale ? 'Inhale' : 'Exhale',
      style: _fontProvider.breathingtext(),
    );
    //! This creates a text painter
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    //! This lays out the text.
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );

    //! This calculates the position to center the text in the middle of the pulsating animation.
    final xPos = (size.width - textPainter.width) / 2;
    final yPos = (size.height - textPainter.height) / 2;

    //! This paints the text on the canvas in the middle of the pulsating animation.
    textPainter.paint(canvas, Offset(xPos, yPos));
  }

  //! Paint overrides the paint method to draw the pulsating circles on the canvas.
  @override
  void paint(Canvas canvas, Size size) {
    //! Iterate through waves and draw pulsating circles
    for (int wave = 3; wave >= 0; wave--) {
      drawPulsatingCircle(canvas, wave + _animation.value, size);
    }
  }

  //! Override should Repaint to always repaint when needed
  @override
  bool shouldRepaint(PulsatingCirclesPainter oldDelegate) {
    return true;
  }
}
