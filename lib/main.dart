// lib/main.dart
import 'package:flutter/material.dart';
import 'pages/registerpage.dart';
import 'package:flutter/scheduler.dart';
import 'package:logging/logging.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // Get the default locale
  String get defaultLocale => Platform.localeName;

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });

    Logger logger = Logger('main');
    logger.info('Default locale: $defaultLocale');
    logger.info('Dark mode: $isDarkMode');
  
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegisterPage(),
    );
  }
}
