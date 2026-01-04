import 'package:flutter/material.dart';
import 'package:what_could_be_next/features/what_happened/components/ui_components.dart';
import 'package:what_could_be_next/features/what_happened/what_happened_controller.dart';
import 'package:what_could_be_next/model/animal.dart';
import 'package:what_could_be_next/model/type_enums.dart';
import 'package:what_could_be_next/ui/components.dart';

// Step 3: Variant Selection
class Step3Widget extends StatelessWidget {
  final WhatHappenedController controller;
  final AnimalColor selectedColor;
  final AnimalType selectedAnimal;
  final List<List<Animal>> animalVariants;

  const Step3Widget({
    super.key,
    required this.controller,
    required this.selectedColor,
    required this.selectedAnimal,
    required this.animalVariants,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const GlassContainer(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Choose Variants',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: animalVariants.length,
                separatorBuilder:
                    (context, index) => const SizedBox(height: 24),
                itemBuilder: (context, index) {
                  final adjacentAnimals = animalVariants[index];

                  return VariantSelector(
                    title:
                        "${selectedAnimal.asLetter()} ${selectedAnimal.asFullName()} ${index + 1}",
                    animalType: selectedAnimal,
                    backgroundColor: selectedColor.asColor(),
                    adjacentAnimals: adjacentAnimals,
                    onVariantSelected:
                        (variant) =>
                            controller.selectVariant(selectedAnimal, variant),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            GlassButton(text: 'Skip', onTap: controller.skipStep3),
          ],
        ),
      ),
    );
  }
}
