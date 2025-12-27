import 'package:what_could_be_next/utils/app_logger.dart';

final MainLogger logger = AppLogger();

void debugLog(String? tag, dynamic message) => logger.d(message);
