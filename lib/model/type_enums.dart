import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'type_enums.g.dart';

@HiveType(typeId: 0)
enum AnimalType {
  @HiveField(0)
  panda,
  @HiveField(1)
  tiger,
  @HiveField(2)
  elephant,
  @HiveField(3)
  crocodile;

  String asLetter() {
    return switch (this) {
      AnimalType.panda => '🐼',

      AnimalType.tiger => '🐯',

      AnimalType.elephant => '🐘',

      AnimalType.crocodile => '🐊',
    };
  }

  String asFullName() {
    return switch (this) {
      AnimalType.panda => 'Panda',

      AnimalType.tiger => 'Tiger',

      AnimalType.elephant => 'Elephant',

      AnimalType.crocodile => 'Crocodile',
    };
  }
}

@HiveType(typeId: 1)
enum AnimalColor {
  @HiveField(0)
  red,
  @HiveField(1)
  green,
  @HiveField(2)
  yellow,
  @HiveField(3)
  unknown;

  Color asColor() {
    return switch (this) {
      AnimalColor.red => Colors.red,
      AnimalColor.green => Colors.green,
      AnimalColor.yellow => Colors.yellow,
      AnimalColor.unknown => Colors.grey.shade700,
    };
  }
}
