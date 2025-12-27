import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension NavExtensions on BuildContext {
  // for navigations
  Future<T?> navigate<T>(String routeName, {Object? arguments}) {
    return Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  Future<T?> navigateReplace<T>(String routeName, {Object? arguments}) {
    return Navigator.pushReplacementNamed(
      this,
      routeName,
      arguments: arguments,
    );
  }

  void goBack({Object? results}) {
    if (!mounted) return;
    if (Navigator.of(this).canPop()) {
      Navigator.pop(this, results);
    } else {
      SystemNavigator.pop(animated: true);
    }
  }

  void pushAndRemoveUntil(String routeName, {Object? arguments}) {
    Navigator.pushNamedAndRemoveUntil(
      this,
      routeName,
      (_) => false,
      arguments: arguments,
    );
  }
}
