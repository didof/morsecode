import 'package:flutter/material.dart';

Route transitionsAuthentication(Widget landingPage) {
  return PageRouteBuilder(
    fullscreenDialog: true,
    transitionDuration: const Duration(seconds: 1),
    pageBuilder: (context, animation, secondaryAnimation) => landingPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween(begin: Offset(0.0, 1.0), end: Offset.zero);
      final curvedAnimation =
          CurvedAnimation(parent: animation, curve: Curves.easeInOut);

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}
