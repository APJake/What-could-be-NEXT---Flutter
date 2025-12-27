import 'package:flutter/cupertino.dart';
import 'package:what_could_be_next/ui/route/utils/app_transitions.dart';

Route appRouter({
  AppTransitions transition = AppTransitions.leftToRight,
  required Widget Function() page,
  required RouteSettings settings,
}) {
  return switch (transition) {
    AppTransitions.none => CupertinoPageRoute(
      builder: (_) => page(),
      settings: settings,
    ),
    AppTransitions.leftToRight => CupertinoPageRoute(
      builder: (_) => page(),
      settings: settings,
    ),
    AppTransitions.rightToLeft => CupertinoPageRoute(
      builder: (_) => page(),
      settings: settings,
    ),
  };
}
