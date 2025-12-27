import 'package:uuid/uuid.dart';

class AppHelper {
  static String get randomUuid => Uuid().v4();
}
