import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:what_could_be_next/box/animal_item_box.dart';
import 'package:what_could_be_next/data/animal_guesser.dart';
import 'package:what_could_be_next/di/riverpod_providers.dart';
import 'package:what_could_be_next/model/animal_guess.dart';
import 'package:what_could_be_next/model/animal_item.dart';

part 'animal_controller.g.dart';

class AnimalControllerState {
  final AnimalGuessResult? guessResult;
  final List<AnimalItem> items;

  AnimalControllerState({this.guessResult, this.items = const []});

  AnimalControllerState copyWith({
    AnimalGuessResult? guessResult,
    List<AnimalItem>? items,
  }) {
    return AnimalControllerState(
      guessResult: guessResult ?? this.guessResult,
      items: items ?? this.items,
    );
  }
}

@Riverpod(keepAlive: true)
class AnimalController extends _$AnimalController {
  late final StreamSubscription _subscription;
  late final AnimalItemBox _box;
  late final AnimalGuesser _guesser;

  @override
  AnimalControllerState build() {
    _box = ref.read(animalItemBoxProvider);
    _guesser = ref.read(animalGuesserProvider);
    _subscription = _box.getAllStream().listen(_onItemsChanged);

    ref.onDispose(() {
      _subscription.cancel();
    });
    return AnimalControllerState();
  }

  void _onItemsChanged(List<AnimalItem> items) {
    final reversedList = items.reversed.toList();
    state = state.copyWith(items: reversedList);
    final guessResult = _guesser.guessNextAnimals(items);
    state = state.copyWith(guessResult: guessResult);
  }

  void addItem(AnimalItem item) {
    _box.add(item);
    state = state.copyWith(items: [...state.items, item]);
  }

  void clear() {
    _box.clear();
    state = state.copyWith(items: []);
  }
}
