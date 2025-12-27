import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:what_could_be_next/model/type_enums.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;

  const GlassContainer({Key? key, required this.child, this.borderRadius = 16})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class ColorBox extends StatelessWidget {
  final Color color;
  final String label;
  final VoidCallback onTap;

  const ColorBox({
    Key? key,
    required this.color,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimalBox extends StatelessWidget {
  final Color backgroundColor;
  final String letter;
  final AnimalType animalType;
  final VoidCallback onTap;

  const AnimalBox({
    Key? key,
    required this.backgroundColor,
    required this.letter,
    required this.animalType,
    required this.onTap,
  }) : super(key: key);

  String getAnimalName() {
    switch (animalType) {
      case AnimalType.panda:
        return 'Panda';
      case AnimalType.tiger:
        return 'Tiger';
      case AnimalType.elephant:
        return 'Elephant';
      case AnimalType.crocodile:
        return 'Crocodile';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                letter,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                getAnimalName(),
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GlassButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const GlassButton({Key? key, required this.text, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const GlassIconButton({Key? key, required this.icon, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        borderRadius: 12,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}
