// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health/health.dart';
import 'package:mealci/pages/health_report.dart';
import 'package:mealci/pages/register_poop_page.dart';
import 'package:mealci/pages/secret_page.dart';
import 'package:mealci/utils/env/environnementvariable.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:mealci/utils/logger/logger.dart';
import 'package:mealci/utils/routes/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mealci/utils/secure_storage/secure_storage_management.dart';
import 'package:url_launcher/url_launcher.dart';
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
  await dotenv.load(fileName: ".env");
  EnvironnementVariable.apiUrl = kDebugMode
      ? EnvironnementVariable.apiUrlDev
      : EnvironnementVariable.apiUrlProd;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isAlreadyLoggedIn = false;
  bool isLoading = true; // Permet d'afficher un loader

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  void checkAppMode() {
    if (kDebugMode) {
      EnvironnementVariable.apiUrl = EnvironnementVariable.apiUrlDev;
    } else {
      EnvironnementVariable.apiUrl = EnvironnementVariable.apiUrlProd;
    }
  }

  void keepScreenPortraitOnly() {
    if (kIsWeb) {
      return;
    }
    if (Platform.isAndroid || Platform.isIOS) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  Future<void> _checkToken() async {
    String? token = await SecureStorageManagement().readData("token_jwt");
    if (token != null && token.isNotEmpty) {
      setState(() {
        isAlreadyLoggedIn = false;
      });
    }
    setState(() {
      isLoading = false; // Indique que la vérification est terminée
    });
  }

  Future<void> requestHealthPermissions(BuildContext context) async {
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
      if (Platform.isAndroid) {
        bool isHealthConnectAvailable = await health.isHealthConnectAvailable();
        if (!isHealthConnectAvailable) {
          _promptToInstallHealthConnect(context);
        }
      }
    }
  }

  void _promptToInstallHealthConnect(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Google Health Connect non disponible"),
          content: Text(
              "L'application Google Health Connect n'est pas installée sur cet appareil. Voulez-vous l'installer ?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _launchHealthConnectInstallation();
                Navigator.of(context).pop();
              },
              child: Text("Installer"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annuler"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchHealthConnectInstallation() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.google.android.apps.healthdata';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      debugPrint("Impossible d'ouvrir le Play Store");
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestHealthPermissions(context);
    });
    MealciLogger.initialize();
    keepScreenPortraitOnly();
    checkAppMode();

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: isAlreadyLoggedIn ? Routes.home : Routes.loginthirdpage,
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
        Routes.registerPoopPage: (context) => const RegisterPoopPage(),
        Routes.secretPage: (context) => const HiddenPage(),
      },
    );
  }
}
