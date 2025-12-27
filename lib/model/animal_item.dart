import 'package:hive/hive.dart';
import 'package:what_could_be_next/model/animal.dart';
import 'package:what_could_be_next/model/type_enums.dart';

part 'animal_item.g.dart';

@HiveType(typeId: 12)
class AnimalItem {
  @HiveField(0)
  final Animal? animal;
  @HiveField(1)
  final AnimalColor? color;

  AnimalItem({required this.animal, required this.color});
}
