// lib/main.dart
import 'package:flutter/material.dart';
import 'package:mealci/utils/env/environnementvariable.dart';
import 'package:flutter/scheduler.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:mealci/utils/logger/logger.dart';
import 'package:mealci/utils/routes/routes.dart';

// pages
import 'package:mealci/pages/register_page.dart';
import 'package:mealci/pages/loginthird_page.dart';
import 'package:mealci/pages/login_page.dart';
import 'package:mealci/pages/home.dart';

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
    // Check app mode to change API URL
    checkAppMode();

    // Init logger
    MealciLogger.initialize();
  
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: Routes.loginthirdpage,
      routes: {
        Routes.home: (context) => const HomePage(),
        Routes.loginPage: (context) => const LoginPage(),
        Routes.loginthirdpage: (context) => const LoginThirdPage(),
        Routes.registerpage: (context) => const RegisterPage(),
      },
    );
  }
}
