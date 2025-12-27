// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimalItemAdapter extends TypeAdapter<AnimalItem> {
  @override
  final int typeId = 12;

  @override
  AnimalItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnimalItem(
      animal: fields[0] as Animal?,
      color: fields[1] as AnimalColor?,
    );
  }

  @override
  void write(BinaryWriter writer, AnimalItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.animal)
      ..writeByte(1)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
