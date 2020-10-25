import 'package:flutter/material.dart';

enum Direction {
  top,
  right,
  bottom,
  left,
}

Route transitionFrom(Direction direction, {@required Widget landingPage}) {
  Offset beginOffset;
  if (direction == Direction.top) {
    beginOffset = Offset(0.0, -1.0);
  } else if (direction == Direction.right) {
    beginOffset = Offset(1.0, 0.0);
  } else if (direction == Direction.bottom) {
    beginOffset = Offset(0.0, 1.0);
  } else if (direction == Direction.left) {
    beginOffset = Offset(-1.0, 0.0);
  }
  return PageRouteBuilder(
    fullscreenDialog: true,
    transitionDuration: const Duration(seconds: 1),
    pageBuilder: (context, animation, secondaryAnimation) => landingPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween(begin: beginOffset, end: Offset.zero);
      final curvedAnimation =
          CurvedAnimation(parent: animation, curve: Curves.easeInOut);

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}
