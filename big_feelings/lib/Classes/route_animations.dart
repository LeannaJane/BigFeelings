// route_animations.dart
import 'package:flutter/material.dart';

//! Changed the methods into a class.
class RouteAnimations {
  //! Page route transition animation for forward navigation
  static PageRouteBuilder forwardAnimation(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        //! This changes where the slide starts and finishes.
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        //! This changes how it comes in and out.
        var curve = Curves.easeInOutExpo;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        //! Slide to the left for back navigation
        if (secondaryAnimation.status == AnimationStatus.reverse) {
          offsetAnimation = secondaryAnimation
              .drive(Tween(begin: const Offset(-1.0, 0.0), end: Offset.zero));
        }

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  //!  Changed to a static method
  //! Page route transition animation for backward navigation
  static PageRouteBuilder backAnimation(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        //! Slide from the left
        var begin = const Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeInExpo;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
