import 'package:flutter/material.dart';

extension NumberExtensions on num {
  Widget verticle() => SizedBox(
        height: (this is double) ? this as double : (this as int).toDouble(),
      );
  Widget horizontal() => SizedBox(
        width: (this is double) ? this as double : (this as int).toDouble(),
      );
}
