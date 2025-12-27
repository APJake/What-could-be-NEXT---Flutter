import 'package:test/test.dart';
import 'package:what_could_be_next/data/animal_guesser.dart';
import 'package:what_could_be_next/model/animal.dart';
import 'package:what_could_be_next/model/animal_item.dart';
import 'package:what_could_be_next/model/type_enums.dart';

void main() {
  AnimalGuesser animalGuesser = AnimalGuesser();

  group('AnimalGuess Logic Tests', () {
    test('Should return 25% for all animals when history is empty', () {
      final history = <AnimalItem>[];
      final result = animalGuesser.guessNextAnimals(history);

      expect(result.guesses.length, equals(4));
      for (var guess in result.guesses) {
        expect(guess.percentage, equals(25.0));
      }
      expect(result.optionalGuesses, isEmpty);
    });

    test('Should prioritize exact sequence (Type + Variant) in guesses', () {
      // Sequence: [Panda(v1), Tiger(v1)] -> Elephant
      final history = [
        AnimalItem(
          animal: Animal(type: AnimalType.panda, variant: 1),
          color: null,
        ),
        AnimalItem(
          animal: Animal(type: AnimalType.tiger, variant: 1),
          color: null,
        ),
        AnimalItem(animal: Animal(type: AnimalType.elephant), color: null),

        // Current state: [Panda(v1), Tiger(v1)]
        AnimalItem(
          animal: Animal(type: AnimalType.panda, variant: 1),
          color: null,
        ),
        AnimalItem(
          animal: Animal(type: AnimalType.tiger, variant: 1),
          color: null,
        ),
      ];

      final result = animalGuesser.guessNextAnimals(history);

      final elephantGuess = result.guesses.firstWhere(
        (g) => g.animalType == AnimalType.elephant,
      );
      expect(elephantGuess.percentage, equals(100.0));
      expect(
        result.optionalGuesses,
        isEmpty,
        reason:
            'Optional should be empty if the exact match was found elsewhere',
      );
    });

    test(
      'Should provide optionalGuesses when types match but variants differ',
      () {
        // Historical Sequence: Panda(v1) -> Tiger(v1) -> Crocodile
        // Current Sequence:    Panda(v2) -> Tiger(v2)

        final history = [
          AnimalItem(
            animal: Animal(type: AnimalType.panda, variant: 1),
            color: null,
          ),
          AnimalItem(
            animal: Animal(type: AnimalType.tiger, variant: 1),
            color: null,
          ),
          AnimalItem(animal: Animal(type: AnimalType.crocodile), color: null),

          // Current trigger with different variants
          AnimalItem(
            animal: Animal(type: AnimalType.panda, variant: 2),
            color: null,
          ),
          AnimalItem(
            animal: Animal(type: AnimalType.tiger, variant: 2),
            color: null,
          ),
        ];

        final result = animalGuesser.guessNextAnimals(history);

        // Exact guesses fallback to 25% because Panda(v2)->Tiger(v2) is new
        expect(result.guesses.every((g) => g.percentage == 25.0), isTrue);

        // Optional guesses should catch the Crocodile based on the Type-only sequence
        final crocOptional = result.optionalGuesses.firstWhere(
          (g) => g.animalType == AnimalType.crocodile,
        );
        expect(crocOptional.percentage, equals(100.0));
      },
    );

    test('Should handle multiple historical outcomes with percentages', () {
      // Sequence A: [Panda, Tiger] -> Elephant
      // Sequence B: [Panda, Tiger] -> Elephant
      // Sequence C: [Panda, Tiger] -> Crocodile
      final history = [
        AnimalItem(animal: Animal(type: AnimalType.panda), color: null),
        AnimalItem(animal: Animal(type: AnimalType.tiger), color: null),
        AnimalItem(animal: Animal(type: AnimalType.elephant), color: null),

        AnimalItem(animal: Animal(type: AnimalType.panda), color: null),
        AnimalItem(animal: Animal(type: AnimalType.tiger), color: null),
        AnimalItem(animal: Animal(type: AnimalType.elephant), color: null),

        AnimalItem(animal: Animal(type: AnimalType.panda), color: null),
        AnimalItem(animal: Animal(type: AnimalType.tiger), color: null),
        AnimalItem(animal: Animal(type: AnimalType.crocodile), color: null),

        // Current state
        AnimalItem(animal: Animal(type: AnimalType.panda), color: null),
        AnimalItem(animal: Animal(type: AnimalType.tiger), color: null),
      ];

      final result = animalGuesser.guessNextAnimals(history);

      final elephantGuess = result.guesses.firstWhere(
        (g) => g.animalType == AnimalType.elephant,
      );
      final crocGuess = result.guesses.firstWhere(
        (g) => g.animalType == AnimalType.crocodile,
      );

      expect(elephantGuess.percentage, closeTo(66.6, 0.1));
      expect(crocGuess.percentage, closeTo(33.3, 0.1));
    });

    test(
      'Should return 25% fallback if the current sequence is entirely unknown',
      () {
        final history = [
          AnimalItem(animal: Animal(type: AnimalType.panda), color: null),
          AnimalItem(animal: Animal(type: AnimalType.tiger), color: null),
          AnimalItem(animal: Animal(type: AnimalType.elephant), color: null),
        ];

        // The sequence [Tiger, Elephant] has no historical "next"
        final result = animalGuesser.guessNextAnimals(history);

        expect(result.guesses.first.percentage, equals(25.0));
        expect(result.optionalGuesses, isEmpty);
      },
    );

    test('Refined Real-world Test', () {
      final List<AnimalItem> history = [];
      void add(AnimalType type, int? variant) {
        history.add(
          AnimalItem(animal: Animal(type: type, variant: variant), color: null),
        );
      }

      // 1. Setup History: 10 times Panda(1)->Tiger(1) -> Elephant
      for (int i = 0; i < 10; i++) {
        add(AnimalType.panda, 1);
        add(AnimalType.tiger, 1);
        add(AnimalType.elephant, null);
      }

      // 2. Add current state (The trigger)
      add(AnimalType.panda, 1);
      add(AnimalType.tiger, 1);

      final result = animalGuesser.guessNextAnimals(history);

      // Validation
      expect(result.guesses.first.animalType, equals(AnimalType.elephant));
      expect(result.guesses.first.percentage, equals(100.0));
    });

    test('Fallback to Optional when Variant is New', () {
      final List<AnimalItem> history = [];
      void add(AnimalType type, int? variant) {
        history.add(
          AnimalItem(animal: Animal(type: type, variant: variant), color: null),
        );
      }

      // History has Panda(v1)->Tiger(v1) -> Crocodile
      add(AnimalType.panda, 1);
      add(AnimalType.tiger, 1);
      add(AnimalType.crocodile, null);

      // Current state is Panda(v99)->Tiger(v99) (Brand new variants)
      add(AnimalType.panda, 99);
      add(AnimalType.tiger, 99);

      final result = animalGuesser.guessNextAnimals(history);

      // Exact match should be 25% default
      expect(result.guesses.first.percentage, equals(25.0));

      // Optional match should find the Crocodile
      expect(
        result.optionalGuesses.first.animalType,
        equals(AnimalType.crocodile),
      );
      expect(result.optionalGuesses.first.percentage, equals(100.0));
    });

    test('Complex Real-World Sequence: Deep Memory vs Optional Logic', () {
      final List<AnimalItem> history = [];

      // Helper to populate history
      void record(AnimalType t, int? v) {
        history.add(
          AnimalItem(animal: Animal(type: t, variant: v), color: null),
        );
      }

      // --- 1. SETUP HISTORICAL DATA ---

      // PATTERN A: The "Royal" Sequence (Strict Variants)
      // [Panda(v99) -> Tiger(v99)] always leads to Elephant
      for (int i = 0; i < 5; i++) {
        record(AnimalType.panda, 99);
        record(AnimalType.tiger, 99);
        record(AnimalType.elephant, 0);
      }

      // PATTERN B: The "Wild" Sequence (Inconsistent Variants)
      // [Panda(any) -> Tiger(any)] usually leads to Crocodile (80%) or Tiger (20%)
      // We use different variants here to "pollute" the variant memory but build species memory.
      for (int i = 0; i < 4; i++) {
        record(AnimalType.panda, i);
        record(AnimalType.tiger, i);
        record(AnimalType.crocodile, 0);
      }
      record(AnimalType.panda, 10);
      record(AnimalType.tiger, 10);
      record(AnimalType.tiger, 0);

      // --- 2. EXECUTE TEST SCENARIOS ---

      // SCENARIO 1: Exact Variant Match
      // We provide the "Royal" sequence trigger.
      record(AnimalType.panda, 99);
      record(AnimalType.tiger, 99);

      var result = animalGuesser.guessNextAnimals(history);

      print('--- Scenario 1: Exact Match ---');
      expect(result.guesses.first.animalType, AnimalType.elephant);
      expect(result.guesses.first.percentage, 100.0);
      expect(result.optionalGuesses, isEmpty);

      // SCENARIO 2: Species Match (New Variants)
      // We use Panda(v500) and Tiger(v500). These specific variants are NOT in history.
      // However, the "Kind" sequence Panda -> Tiger has appeared many times.
      // Total [Panda->Tiger] transitions in history: 5 (to Elephant) + 4 (to Croc) + 1 (to Tiger) = 10
      history.removeLast();
      history.removeLast(); // Clear previous trigger
      record(AnimalType.panda, 500);
      record(AnimalType.tiger, 500);

      result = animalGuesser.guessNextAnimals(history);

      print('\n--- Scenario 2: Species Match (Optional) ---');
      // Guesses should be fallback because v500/v500 is unknown
      expect(result.guesses.every((g) => g.percentage == 25.0), true);

      // Optional should show: Elephant (50%), Crocodile (40%), Tiger (10%)
      final optElephant = result.optionalGuesses.firstWhere(
        (g) => g.animalType == AnimalType.elephant,
      );
      final optCroc = result.optionalGuesses.firstWhere(
        (g) => g.animalType == AnimalType.crocodile,
      );
      final optTiger = result.optionalGuesses.firstWhere(
        (g) => g.animalType == AnimalType.tiger,
      );

      expect(optElephant.percentage, 50.0);
      expect(optCroc.percentage, 40.0);
      expect(optTiger.percentage, 10.0);

      // SCENARIO 3: Absolute Dead End
      // Sequence [Elephant -> Elephant] has never occurred in history.
      history.removeLast();
      history.removeLast();
      record(AnimalType.elephant, 0);
      record(AnimalType.elephant, 0);

      result = animalGuesser.guessNextAnimals(history);

      print('\n--- Scenario 3: Dead End ---');
      expect(result.guesses.every((g) => g.percentage == 25.0), true);
      expect(result.optionalGuesses, isEmpty);
    });
  });
}
