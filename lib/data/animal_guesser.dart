import 'package:what_could_be_next/model/animal.dart';
import 'package:what_could_be_next/model/animal_guess.dart';
import 'package:what_could_be_next/model/animal_item.dart';
import 'package:what_could_be_next/model/type_enums.dart';

class AnimalGuesser {
  AnimalGuessResult guessNextAnimals(List<AnimalItem> history) {
    // If we don't have enough history to form a "Previous -> Last -> Next" pattern
    // (Need at least 3 items to have one historical transition)
    if (history.length < 3) {
      return AnimalGuessResult(
        guesses: _getDefaultProbabilities(),
        optionalGuesses: [],
      );
    }

    // Define the current sequence (the last two items in the list)
    final penultimate = history[history.length - 2];
    final last = history.last;

    final String exactStateKey = _createStateKey(
      penultimate.animal,
      last.animal,
    );
    final String kindStateKey = _createKindKey(penultimate.animal, last.animal);

    Map<AnimalType, int> exactCounts = {};
    Map<AnimalType, int> optionalCounts = {};
    int totalExact = 0;
    int totalOptional = 0;

    // IMPORTANT: We stop at length - 3 because we are looking for
    // what follows the sequence at index i and i+1.
    for (int i = 0; i <= history.length - 3; i++) {
      final h1 = history[i].animal;
      final h2 = history[i + 1].animal;
      final hNext = history[i + 2].animal;

      if (hNext == null) continue;

      if (_createStateKey(h1, h2) == exactStateKey) {
        exactCounts[hNext.type] = (exactCounts[hNext.type] ?? 0) + 1;
        totalExact++;
      }

      if (_createKindKey(h1, h2) == kindStateKey) {
        optionalCounts[hNext.type] = (optionalCounts[hNext.type] ?? 0) + 1;
        totalOptional++;
      }
    }

    // If we found an exact match, we don't need to return those same results in 'optional'
    // But if totalExact is 0, we return the 25% default in 'guesses'
    return AnimalGuessResult(
      guesses:
          totalExact > 0
              ? _mapToGuesses(exactCounts, totalExact)
              : _getDefaultProbabilities(),
      optionalGuesses:
          totalExact > 0 ? [] : _mapToGuesses(optionalCounts, totalOptional),
    );
  }

  // Helper: Exact match key
  String _createStateKey(Animal? a, Animal? b) =>
      "${a?.type}_${a?.variant}-${b?.type}_${b?.variant}";

  // Helper: Kind match key (ignores variants)
  String _createKindKey(Animal? a, Animal? b) => "${a?.type}-${b?.type}";

  List<AnimalGuess> _mapToGuesses(Map<AnimalType, int> counts, int total) {
    if (total == 0) return [];
    return counts.entries
        .map(
          (e) => AnimalGuess(
            animalType: e.key,
            percentage: (e.value / total) * 100,
          ),
        )
        .toList()
      ..sort((a, b) => b.percentage.compareTo(a.percentage));
  }

  List<AnimalGuess> _getDefaultProbabilities() {
    return AnimalType.values
        .map((type) => AnimalGuess(animalType: type, percentage: 25.0))
        .toList();
  }
}
