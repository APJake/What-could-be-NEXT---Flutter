import 'package:hive/hive.dart';
import 'package:what_could_be_next/model/animal.dart';
import 'package:what_could_be_next/model/animal_item.dart';
import 'package:what_could_be_next/model/type_enums.dart';

class AnimalItemBox {
  static const String boxName = "animal_item_box";

  static void registerAdapters() {
    Hive.registerAdapter(AnimalAdapter());
    Hive.registerAdapter(AnimalItemAdapter());
    Hive.registerAdapter(AnimalTypeAdapter());
    Hive.registerAdapter(AnimalColorAdapter());
  }

  AnimalItemBox(this._box);

  final Box<AnimalItem> _box;

  /// Read
  List<AnimalItem> getAll() {
    return _box.values.toList();
  }

  Stream<List<AnimalItem>> getAllStream() async* {
    yield getAll();
    await for (final _ in _box.watch()) {
      yield getAll();
    }
  }

  AnimalItem? getAt(int index) {
    if (index < 0 || index >= _box.length) return null;
    return _box.getAt(index);
  }

  /// Write
  Future<void> add(AnimalItem item) async {
    await _box.add(item);
  }

  Future<void> addAll(List<AnimalItem> items) async {
    await _box.addAll(items);
  }

  /// Update
  Future<void> updateAt(int index, AnimalItem item) async {
    await _box.putAt(index, item);
  }

  /// Delete
  Future<void> deleteAt(int index) async {
    await _box.deleteAt(index);
  }

  Future<void> clear() async {
    await _box.clear();
  }

  /// Helpers
  int get length => _box.length;

  bool get isEmpty => _box.isEmpty;
}
