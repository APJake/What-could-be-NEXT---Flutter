import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';
import 'package:what_could_be_next/box/animal_item_box.dart';
import 'package:what_could_be_next/data/animal_guesser.dart';
import 'package:what_could_be_next/model/animal_guess.dart';
import 'package:what_could_be_next/model/animal_item.dart';

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

class AnimalController extends StateNotifier<AnimalControllerState> {
  final AnimalItemBox _box;
  final AnimalGuesser _guesser;
  late final StreamSubscription _subscription;

  AnimalController(this._box, this._guesser) : super(AnimalControllerState()) {
    _subscription = _box.getAllStream().listen(onItemsChanged);
  }

  void onItemsChanged(List<AnimalItem> items) {
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

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
