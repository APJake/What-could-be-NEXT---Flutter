import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:what_could_be_next/di/riverpod_providers.dart';
import 'package:what_could_be_next/features/what_happened/step1_widget.dart';
import 'package:what_could_be_next/features/what_happened/step2_widget.dart';
import 'package:what_could_be_next/features/what_happened/step3_widget.dart';
import 'package:what_could_be_next/features/what_happened/what_happened_controller.dart';
import 'package:what_could_be_next/features/what_happened/what_happened_state.dart';
import 'package:what_could_be_next/ui/components.dart';
import 'package:what_could_be_next/utils/nav_extensions.dart';

class WhatHappenedScreen extends ConsumerWidget {
  const WhatHappenedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(whatHappenedControllerProvider);
    final controller = ref.read(whatHappenedControllerProvider.notifier);

    ref.listen(whatHappenedControllerProvider, (previous, next) {
      final event = next.uiEvent;
      if (event == null) return;

      switch (event) {
        case WhatHappenedUiEvent.success:
          context.goBack();
          break;
      }
    });

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
