// route_animations.dart
import 'package:flutter/material.dart';

//! Changed the methods into a class.
class RouteAnimations {
  //! Page route transition animation for forward navigation
  static PageRouteBuilder forwardAnimation(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 800),
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
      transitionDuration: const Duration(milliseconds: 800),
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

//! Created another animation as I had issues with the animations with the speed and that the when i returned from the piggy back pages back to the feature page
//! there was bugs that showed the page going too quick or back and forward making a glitch, and this fixed the issue.
  static PageRouteBuilder piggyBackingAnimation(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 800),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.easeOutExpo;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          child: child,
        );
      },
    );
  }
}
