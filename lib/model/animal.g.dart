// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimalAdapter extends TypeAdapter<Animal> {
  @override
  final int typeId = 11;

  @override
  Animal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Animal(
      type: fields[0] as AnimalType,
      variant: fields[1] as int?,
      description: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Animal obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.variant)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
