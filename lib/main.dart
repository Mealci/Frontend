// lib/main.dart
import 'package:flutter/material.dart';
import 'package:mealci/utils/env/environnementvariable.dart';
import 'pages/registerpage.dart';
import 'package:flutter/scheduler.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:mealci/utils/logger/logger.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  bool get isDarkMode {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark;
  }

  String get locale {
    return Platform.localeName;
  }

  void checkAppMode() {
    if (kDebugMode) {
      EnvironnementVariable.apiUrl = EnvironnementVariable.apiUrlDev;
    } else {
      EnvironnementVariable.apiUrl = EnvironnementVariable.apiUrlProd;
    }
  }

  @override
  Widget build(BuildContext context) {

    // Check app mode
    checkAppMode();

    //init logger
    MealciLogger.initialize();
  
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginThirdPage(),
    );
  }
}
