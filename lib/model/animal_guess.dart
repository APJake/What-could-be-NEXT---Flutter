import 'package:what_could_be_next/model/type_enums.dart';

class AnimalGuess {
  final AnimalType animalType;
  final double percentage;

  AnimalGuess({required this.animalType, required this.percentage});
}

class AnimalGuessResult {
  final List<AnimalGuess> guesses;
  final List<AnimalGuess> optionalGuesses;

  AnimalGuessResult({required this.guesses, required this.optionalGuesses});
}
