import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealci/components/custom_snak_bar.dart';
import 'package:mealci/components/save_poop_button.dart';
import 'package:mealci/utils/routes/routes.dart';
import 'package:mealci/utils/styles/style.dart';
import 'package:shake/shake.dart';

class PoopTrackerPage extends StatefulWidget {
  const PoopTrackerPage({super.key});

  @override
  State<PoopTrackerPage> createState() => _PoopTrackerPageState();
}

class _PoopTrackerPageState extends State<PoopTrackerPage> {
  ShakeDetector? _shakeDetector;
  String _shakeInfo = 'Secoue ton téléphone !'; // Variable d'état pour afficher les infos

  @override
  void initState() {
    super.initState();
    _startDetector();
  }

  void _startDetector() {
    // Arrêter le détecteur précédent s'il existe
    _shakeDetector?.stopListening();

    _shakeDetector = ShakeDetector.autoStart(
      onPhoneShake: (ShakeEvent event) {
        setState(() {
          _shakeInfo = 'Direction: ${event.direction}\n'
                       'Force: ${event.force.toStringAsFixed(2)}\n'
                       'Time: ${event.timestamp.toString()}';
        });

        // Affiche une snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tu as secoué le téléphone ! 🚀'))
        );

        Navigator.pushNamed(
          context,
          Routes.secretPage,
        );
      },
    );
  }

  @override
  void dispose() {
    _shakeDetector?.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;
    final screenW = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          children: [
            const Text(
              'Journal Intestinal',
              style: TextStyle(
                color: Colors.black,
                fontSize: 27,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                SvgPicture.asset(
                  CustomMealciAsset.toiletIcon,
                  height: screenH * 0.3,
                  width: screenW * 0.2,
                ),
                SizedBox(height: screenH * 0.03),
                SavePoopButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, Routes.registerPoopPage);
                  },
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
