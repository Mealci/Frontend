import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class MealciLogger {
  final Logger _logger;

  MealciLogger(String name) : _logger = Logger(name);

  void finest(String message) => _logger.finest(message);
  void finer(String message) => _logger.finer(message);
  void fine(String message) => _logger.fine(message);
  void config(String message) => _logger.config(message);
  void info(String message) => _logger.info(message);
  void warning(String message) => _logger.warning(message);
  void severe(String message) => _logger.severe(message);
  void shout(String message) => _logger.shout(message);

  static void initialize() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord record) {
      debugPrint('${record.level.name}: ${record.time}: ${record.message}');
    });
  }
}
