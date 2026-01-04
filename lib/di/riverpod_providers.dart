import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:what_could_be_next/box/animal_item_box.dart';
import 'package:what_could_be_next/data/animal_guesser.dart';
import 'package:what_could_be_next/model/animal_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'riverpod_providers.g.dart';

@riverpod
AnimalGuesser animalGuesser(Ref ref) {
  return AnimalGuesser();
}

@riverpod
AnimalItemBox animalItemBox(Ref ref) {
  final box = Hive.box<AnimalItem>(AnimalItemBox.boxName);
  return AnimalItemBox(box);
}
