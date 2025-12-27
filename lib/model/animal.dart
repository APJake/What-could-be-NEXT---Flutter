import 'package:hive/hive.dart';
import 'package:what_could_be_next/model/type_enums.dart';

part 'animal.g.dart';

@HiveType(typeId: 11)
class Animal {
  @HiveField(0)
  final AnimalType type;
  @HiveField(1)
  final int? variant;
  @HiveField(2)
  final String? description;

  Animal({required this.type, this.variant, this.description});
}
