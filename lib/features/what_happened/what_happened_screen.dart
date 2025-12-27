import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:what_could_be_next/di/riverpod_providers.dart';
import 'package:what_could_be_next/features/what_happened/ui_components.dart';
import 'package:what_could_be_next/features/what_happened/what_happened_controller.dart';
import 'package:what_could_be_next/features/what_happened/what_happened_state.dart';
import 'package:what_could_be_next/model/animal.dart';
import 'package:what_could_be_next/model/type_enums.dart';
import 'package:what_could_be_next/ui/components.dart';

class WhatHappenedScreen extends ConsumerWidget {
  const WhatHappenedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(whatHappenedControllerProvider);
    final controller = ref.read(whatHappenedControllerProvider.notifier);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.shade900,
              Colors.blue.shade900,
              Colors.pink.shade900,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context, state, controller),
              Expanded(child: _buildCurrentStep(context, state, controller)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(
    BuildContext context,
    WhatHappenedState state,
    WhatHappenedController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          if (state.currentStep > 1)
            GlassIconButton(icon: Icons.arrow_back, onTap: controller.goBack),
          const SizedBox(width: 16),
          Expanded(
            child: GlassContainer(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Text(
                  'Step ${state.currentStep} of 3',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep(
    BuildContext context,
    WhatHappenedState state,
    WhatHappenedController controller,
  ) {
    switch (state.currentStep) {
      case 1:
        return Step1Widget(controller: controller);
      case 2:
        return Step2Widget(
          controller: controller,
          selectedColor: state.selectedColor!,
        );
      case 3:
        return Step3Widget(
          controller: controller,
          selectedColor: state.selectedColor!,
          selectedAnimal: state.selectedAnimal!,
          animalVariants: state.animalVariants,
        );
      default:
        return const SizedBox();
    }
  }
}

// Step 1: Color Selection
class Step1Widget extends StatelessWidget {
  final WhatHappenedController controller;

  const Step1Widget({super.key, required this.controller});

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
                  'Choose a Color',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                ColorBox(
                  color: Colors.red,
                  label: 'Red',
                  onTap: () => controller.selectColor(AnimalColor.red),
                ),
                ColorBox(
                  color: Colors.green,
                  label: 'Green',
                  onTap: () => controller.selectColor(AnimalColor.green),
                ),
                ColorBox(
                  color: Colors.yellow,
                  label: 'Yellow',
                  onTap: () => controller.selectColor(AnimalColor.yellow),
                ),
                ColorBox(
                  color: Colors.grey.shade700,
                  label: 'Unknown',
                  onTap: () => controller.selectColor(AnimalColor.unknown),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Step 2: Animal Selection
class Step2Widget extends StatelessWidget {
  final WhatHappenedController controller;
  final AnimalColor selectedColor;

  const Step2Widget({
    super.key,
    required this.controller,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = selectedColor.asColor();

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
                  'Choose an Animal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children:
                    AnimalType.values
                        .map(
                          (e) => AnimalBox(
                            backgroundColor: bgColor,
                            letter: e.asLetter(),
                            animalType: e,
                            onTap: () => controller.selectAnimal(e),
                          ),
                        )
                        .toList(),
              ),
            ),
            const SizedBox(height: 16),
            GlassButton(text: 'Skip', onTap: controller.skipStep2),
          ],
        ),
      ),
    );
  }
}

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
