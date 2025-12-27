import 'package:flutter/material.dart';

enum AppTransitions {
  none,
  leftToRight,
  rightToLeft;
}

class TransitionRoutes {
  static Route none({
    required Widget Function() page,
    required RouteSettings settings,
  }) {
    return MaterialPageRoute(
      builder: (_) => page(),
      settings: settings,
    );
  }

  static Route leftToRight({
    required Widget Function() page,
    required RouteSettings settings,
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Route rightToLeft({
    required Widget Function() page,
    required RouteSettings settings,
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
