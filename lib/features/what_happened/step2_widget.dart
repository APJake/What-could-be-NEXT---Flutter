import 'package:flutter/material.dart';
import 'package:what_could_be_next/features/what_happened/what_happened_controller.dart';
import 'package:what_could_be_next/model/type_enums.dart';
import 'package:what_could_be_next/ui/components.dart';

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
