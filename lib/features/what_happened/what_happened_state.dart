import 'package:what_could_be_next/model/animal.dart';
import 'package:what_could_be_next/model/type_enums.dart';

class WhatHappenedState {
  final int currentStep;
  final AnimalColor? selectedColor;
  final AnimalType? selectedAnimal;
  final Animal? selectedVariant;
  final List<List<Animal>> animalVariants;

  WhatHappenedState({
    this.currentStep = 1,
    this.selectedColor,
    this.selectedAnimal,
    this.selectedVariant,
    this.animalVariants = const [],
  });

  WhatHappenedState copyWith({
    int? currentStep,
    AnimalColor? selectedColor,
    AnimalType? selectedAnimal,
    Animal? selectedVariant,
    List<List<Animal>>? animalVariants,
  }) {
    return WhatHappenedState(
      currentStep: currentStep ?? this.currentStep,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedAnimal: selectedAnimal ?? this.selectedAnimal,
      selectedVariant: selectedVariant ?? this.selectedVariant,
      animalVariants: animalVariants ?? this.animalVariants,
    );
  }

  bool get canShowStep3 => selectedAnimal != null;
}
