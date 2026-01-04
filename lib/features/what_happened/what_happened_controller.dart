import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:what_could_be_next/controller/animal_controller.dart';
import 'package:what_could_be_next/di/app_dependency.dart';
import 'package:what_could_be_next/features/what_happened/what_happened_state.dart';
import 'package:what_could_be_next/model/animal.dart';
import 'package:what_could_be_next/model/animal_item.dart';
import 'package:what_could_be_next/model/animals_constant.dart';
import 'package:what_could_be_next/model/type_enums.dart';

part 'what_happened_controller.g.dart';

@riverpod
class WhatHappenedController extends _$WhatHappenedController {
  late final AnimalController _animalController;

  @override
  WhatHappenedState build() {
    _animalController = ref.read(animalControllerProvider.notifier);
    return WhatHappenedState();
  }

  void selectColor(AnimalColor color) {
    state = state.copyWith(selectedColor: color, currentStep: 2);
  }

  void selectAnimal(AnimalType animal) {
    final variants = AnimalsConstant.animalVariants[animal] ?? [];

    state = state.copyWith(
      selectedAnimal: animal,
      currentStep: 3,
      animalVariants: variants,
    );
  }

  void skipStep2() {
    completeFlow();
  }

  void selectVariant(AnimalType animal, int variant) {
    final neighbours = AnimalsConstant.getNeighbours(animal, variant);
    final descriptionText = neighbours.map((e) => e.type.asLetter()).join(" ");

    state = state.copyWith(
      selectedVariant: Animal(
        type: animal,
        variant: variant,
        description: descriptionText,
      ),
    );

    completeFlow();
  }

  void skipStep3() {
    completeFlow();
  }

  void completeFlow() {
    logger.d('Flow completed!');
    logger.d('Color: ${state.selectedColor}');
    logger.d('Animal: ${state.selectedAnimal}');
    logger.d('Variant: ${state.selectedVariant?.variant}');

    final animalItem = AnimalItem(
      animal: state.selectedVariant,
      color: state.selectedColor,
    );
    _animalController.addItem(animalItem);

    onSuccess();
  }

  void onSuccess() {
    state = WhatHappenedState(uiEvent: WhatHappenedUiEvent.success);
  }

  void goBack() {
    if (state.currentStep > 1) {
      if (state.currentStep == 3) {
        state = state.copyWith(
          currentStep: 2,
          selectedAnimal: null,
          selectedVariant: null,
          animalVariants: [],
        );
      } else if (state.currentStep == 2) {
        state = state.copyWith(currentStep: 1, selectedColor: null);
      }
    }
  }
}
