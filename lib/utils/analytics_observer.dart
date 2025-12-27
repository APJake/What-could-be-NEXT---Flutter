// A Navigator observer that notifies RouteAwares of changes to state of their Route
import 'package:flutter/material.dart';
import 'package:what_could_be_next/di/app_dependency.dart';

class AnalyticsObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    // Extract route name
    var screenName = route.settings.name ?? 'Unknown';

    // Extract route arguments
    final arguments =
        route.settings.arguments != null
            ? route.settings.arguments.toString()
            : 'No arguments';

    // Log or send both screen name and arguments to Firebase Analytics
    // AnalyticsHelper.logScreenView(
    //   screenName: screenName,
    //   arguments: arguments,
    // );

    logger.t('Navigated to $screenName with arguments $arguments');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);

    // Extract previous route's name and arguments
    var screenName = previousRoute?.settings.name ?? 'Unknown';
    final arguments =
        previousRoute?.settings.arguments != null
            ? previousRoute!.settings.arguments.toString()
            : 'No arguments';

    // Log or send screen name and arguments for the previous screen
    // AnalyticsHelper.logScreenView(
    //   screenName: screenName,
    //   arguments: arguments,
    // );

    logger.t('Popped to $screenName with arguments $arguments');
  }
}
