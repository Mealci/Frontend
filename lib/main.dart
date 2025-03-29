// lib/main.dart
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:mealci/pages/health_report.dart';
import 'package:mealci/pages/register_poop_page.dart';
import 'package:mealci/utils/env/environnementvariable.dart';
import 'package:flutter/scheduler.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:mealci/utils/logger/logger.dart';
import 'package:mealci/utils/routes/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'components/qr_camera_preview_screen.dart';

// pages
import 'package:mealci/pages/register_page.dart';
import 'package:mealci/pages/loginthird_page.dart';
import 'package:mealci/pages/login_page.dart';
import 'package:mealci/pages/home.dart';
import 'package:mealci/pages/toilet_map_page.dart';
import 'package:mealci/pages/frigo_page.dart';

// Global Health Instance
final health = Health();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await requestHealthPermissions();
  await dotenv.load(fileName: ".env");
  EnvironnementVariable.apiUrl = kDebugMode
      ? EnvironnementVariable.apiUrlDev
      : EnvironnementVariable.apiUrlProd;
  runApp(const MyApp());
}

Future<void> requestHealthPermissions() async {
  List<HealthDataType> types = HealthDataType.values;

  bool? hasPermissions = await health.hasPermissions(types);

  if (!(hasPermissions ?? false)) {
    List<HealthDataAccess> permissions = [];
    for (var _ in types) {
      permissions.add(HealthDataAccess.READ);
    }
    bool authorized =
        await health.requestAuthorization(types, permissions: permissions);
    if (!authorized) {
      debugPrint("HealthKit permissions not granted");
    } else {
      debugPrint("HealthKit permissions granted");
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  bool get isDarkMode {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark;
  }

  String get locale {
    return Platform.localeName;
  }

  @override
  Widget build(BuildContext context) {
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
        Routes.textRecognitionScreen: (context) => const HomePage(),
        Routes.toiletMap: (context) => const ToiletMapPage(),
        Routes.scanBarCode: (context) => const QrCameraPreviewScreen(),
        Routes.frigoPage: (context) => const FrigoPage(),
        Routes.healthReport: (context) => const HealthReport(),
        Routes.registerPoopPage: (context) => const RegisterPoopPage()
      },
    );
  }
}
