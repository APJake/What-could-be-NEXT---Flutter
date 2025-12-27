import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  // padding
  double get safePadding => MediaQuery.of(this).padding.top;
  double get deviceWidth => MediaQuery.sizeOf(this).width;
  double get deviceHeight => MediaQuery.sizeOf(this).height;

  // theming
  bool get isDarkMode {
    var brightness = MediaQuery.of(this).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return isDarkMode;
  }

  ThemeData get theme => Theme.of(this);

  ColorScheme get color => Theme.of(this).colorScheme;

  // snack message
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }
}
