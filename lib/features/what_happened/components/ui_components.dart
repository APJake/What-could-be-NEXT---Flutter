import 'package:flutter/material.dart';
import 'package:what_could_be_next/model/animal.dart';
import 'package:what_could_be_next/model/type_enums.dart';
import 'package:what_could_be_next/ui/components.dart';

class VariantSelector extends StatelessWidget {
  final String title;
  final AnimalType animalType;
  final Color backgroundColor;
  final List<Animal> adjacentAnimals;

  final Function(int) onVariantSelected;

  const VariantSelector({
    super.key,
    required this.title,
    required this.animalType,
    required this.backgroundColor,
    required this.adjacentAnimals,
    required this.onVariantSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onVariantSelected(adjacentAnimals[1].variant ?? 0),
      child: GlassContainer(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children:
                    adjacentAnimals
                        .map(
                          (e) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VariantBox(
                                letter: e.type.asLetter(),
                                fullname: e.type.asFullName(),
                                backgroundColor: backgroundColor,
                                isSelected: e.type == animalType,
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VariantBox extends StatelessWidget {
  final String letter;
  final String fullname;
  final bool isSelected;
  final Color backgroundColor;

  const VariantBox({
    super.key,
    required this.letter,
    required this.fullname,
    required this.isSelected,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor =
        isSelected ? backgroundColor : AnimalColor.unknown.asColor();

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isSelected ? bgColor.withOpacity(0.6) : bgColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              isSelected
                  ? Colors.white.withOpacity(0.6)
                  : Colors.white.withOpacity(0.2),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            letter,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          // 12.verticle(),
          Text(
            fullname,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
