import 'package:what_could_be_next/model/animal.dart';
import 'package:what_could_be_next/model/type_enums.dart';

class AnimalsConstant {
  AnimalsConstant._();

  static final animalVariants = {
    AnimalType.panda: pandaVariants,
    AnimalType.tiger: tigerVariants,
    AnimalType.elephant: elephantVariants,
    AnimalType.crocodile: crocodileVariants,
  };

  static final pandaVariants = [
    [
      Animal(type: AnimalType.crocodile),
      Animal(type: AnimalType.panda, variant: 1, description: "4 times"),
      Animal(type: AnimalType.elephant),
    ],
    [
      Animal(type: AnimalType.tiger),
      Animal(type: AnimalType.panda, variant: 2, description: "3 times"),
      Animal(type: AnimalType.tiger),
    ],
    [
      Animal(type: AnimalType.tiger),
      Animal(type: AnimalType.panda, variant: 3, description: "1 times"),
      Animal(type: AnimalType.elephant),
    ],
  ];

  static final tigerVariants = [
    [
      Animal(type: AnimalType.elephant),
      Animal(type: AnimalType.tiger, variant: 1, description: "4 times"),
      Animal(type: AnimalType.panda),
    ],
    [
      Animal(type: AnimalType.panda),
      Animal(type: AnimalType.tiger, variant: 2, description: "3 times"),
      Animal(type: AnimalType.crocodile),
    ],
  ];

  static final elephantVariants = [
    [
      Animal(type: AnimalType.panda),
      Animal(type: AnimalType.elephant, variant: 1, description: "4 times"),
      Animal(type: AnimalType.tiger),
    ],
    [
      Animal(type: AnimalType.panda),
      Animal(type: AnimalType.elephant, variant: 2, description: "1 times"),
      Animal(type: AnimalType.crocodile),
    ],
  ];

  static final crocodileVariants = [
    [
      Animal(type: AnimalType.tiger),
      Animal(type: AnimalType.crocodile, variant: 1, description: "3 times"),
      Animal(type: AnimalType.panda),
    ],
    [
      Animal(type: AnimalType.elephant),
      Animal(type: AnimalType.crocodile, variant: 2, description: "1 times"),
      Animal(type: AnimalType.panda),
    ],
  ];
}
