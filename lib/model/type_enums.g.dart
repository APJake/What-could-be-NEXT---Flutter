// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimalTypeAdapter extends TypeAdapter<AnimalType> {
  @override
  final int typeId = 0;

  @override
  AnimalType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AnimalType.panda;
      case 1:
        return AnimalType.tiger;
      case 2:
        return AnimalType.elephant;
      case 3:
        return AnimalType.crocodile;
      default:
        return AnimalType.panda;
    }
  }

  @override
  void write(BinaryWriter writer, AnimalType obj) {
    switch (obj) {
      case AnimalType.panda:
        writer.writeByte(0);
        break;
      case AnimalType.tiger:
        writer.writeByte(1);
        break;
      case AnimalType.elephant:
        writer.writeByte(2);
        break;
      case AnimalType.crocodile:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AnimalColorAdapter extends TypeAdapter<AnimalColor> {
  @override
  final int typeId = 1;

  @override
  AnimalColor read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AnimalColor.red;
      case 1:
        return AnimalColor.green;
      case 2:
        return AnimalColor.yellow;
      case 3:
        return AnimalColor.unknown;
      default:
        return AnimalColor.red;
    }
  }

  @override
  void write(BinaryWriter writer, AnimalColor obj) {
    switch (obj) {
      case AnimalColor.red:
        writer.writeByte(0);
        break;
      case AnimalColor.green:
        writer.writeByte(1);
        break;
      case AnimalColor.yellow:
        writer.writeByte(2);
        break;
      case AnimalColor.unknown:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalColorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
