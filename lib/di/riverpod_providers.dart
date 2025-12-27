import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import 'package:what_could_be_next/box/animal_item_box.dart';
import 'package:what_could_be_next/controller/animal_controller.dart';
import 'package:what_could_be_next/data/animal_guesser.dart';
import 'package:what_could_be_next/features/what_happened/what_happened_controller.dart';
import 'package:what_could_be_next/features/what_happened/what_happened_state.dart';
import 'package:what_could_be_next/model/animal_item.dart';

final animalGuesserProvider = Provider<AnimalGuesser>((ref) {
  return AnimalGuesser();
});

final animalItemBoxProvider = Provider<AnimalItemBox>((ref) {
  final box = Hive.box<AnimalItem>(AnimalItemBox.boxName);
  return AnimalItemBox(box);
});

final whatHappenedControllerProvider = StateNotifierProvider<
  WhatHappenedController,
  WhatHappenedState
>((ref) => WhatHappenedController(ref.read(animalControllerProvider.notifier)));

final animalControllerProvider =
    StateNotifierProvider<AnimalController, AnimalControllerState>(
      (ref) => AnimalController(
        ref.read(animalItemBoxProvider),
        ref.read(animalGuesserProvider),
      ),
    );
