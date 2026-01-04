import 'package:flutter/material.dart';
import 'package:what_could_be_next/features/what_happened/what_happened_controller.dart';
import 'package:what_could_be_next/model/type_enums.dart';
import 'package:what_could_be_next/ui/components.dart';

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
