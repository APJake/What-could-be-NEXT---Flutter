import 'package:flutter/widgets.dart';
import 'package:what_could_be_next/features/entry/error_screen.dart';
import 'package:what_could_be_next/features/entry/splash_screen.dart';
import 'package:what_could_be_next/features/home/home_screen.dart';
import 'package:what_could_be_next/features/what_happened/what_happened_screen.dart';
import 'package:what_could_be_next/ui/route/utils/app_router.dart';
import 'package:what_could_be_next/ui/route/utils/app_transitions.dart';

class AppRoute {
  AppRoute._();

  static const String splash = "/";
  static const String home = "/home";
  static const String create = "/create";

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return appRouter(
          transition: AppTransitions.none,
          page: () => SplashScreen(),
          settings: settings,
        );
      case home:
        return appRouter(page: () => const HomeScreen(), settings: settings);
      case create:
        return appRouter(
          page: () => const WhatHappenedScreen(),
          settings: settings,
        );
      default:
        return appRouter(
          transition: AppTransitions.none,
          page: () => const ErrorScreen(),
          settings: settings,
        );
    }
  }
}
