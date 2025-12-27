import 'package:logger/logger.dart';

abstract class MainLogger {
  void t(dynamic message);
  void i(dynamic message);
  void d(dynamic message);
  void e(dynamic message);
  void f(dynamic message);
  void w(dynamic message);
}

class AppLogger implements MainLogger {
  final Logger _logger = Logger(printer: PrettyPrinter());

  // void _analyze(String level, dynamic message) {
  //   // will implement when we start to integrate with firebase analytics

  //   // _analytics.logEvent(name: 'app_logger', parameters: {
  //   //   'level': level,
  //   //   'app_logger_message': message,
  //   // });
  // }

  @override
  void d(message) {
    _logger.d(message);
  }

  @override
  void e(message) {
    _logger.e(message);
  }

  // Use this function to analyze as event
  @override
  void f(message) {
    _logger.f(message);
  }

  @override
  void i(message) {
    _logger.i(message);
  }

  @override
  void t(message) {
    _logger.t(message);
  }

  @override
  void w(message) {
    _logger.w(message);
  }
}
