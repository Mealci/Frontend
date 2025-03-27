import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealci/components/custom_snak_bar.dart';
import 'package:mealci/components/save_poop_button.dart';
import 'package:mealci/utils/routes/routes.dart';
import 'package:mealci/utils/styles/style.dart';

class PoopTrackerPage extends StatefulWidget {
  const PoopTrackerPage({super.key});

  @override
  State<PoopTrackerPage> createState() => _PoopTrackerPageState();
}

class _PoopTrackerPageState extends State<PoopTrackerPage> {
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
              'Suivi des cacas',
              style: TextStyle(
                color: Colors.black,
                fontSize: 27,
                fontWeight: FontWeight.bold,
                fontFamily: 'Voltaire',
              ),
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
            // const Spacer(),
            ElevatedButton(
              onPressed: () {
                CustomSnackBar.show(
                  context,
                  "Nouvelle notification ! 🚀",
                  icon: Icons.check_circle_outline, // Icône custom
                  backgroundColor: Colors.green, // Couleur de fond
                  textColor: Colors.white, // Couleur du texte
                  duration: Duration(seconds: 4), // Durée d'affichage
                );
              },
              child: Text("Afficher SnackBar"),
            ),
            ElevatedButton(
              onPressed: () {
                CustomSnackBar.showError(context, "Erreur ! 😱");
              },
              child: Text("Afficher SnackBar"),
            ),
            ElevatedButton(
              onPressed: () {
                CustomSnackBar.showInfo(context, "Information ! 📢");
              },
              child: Text("Afficher SnackBar"),
            ),
            ElevatedButton(
              onPressed: () {
                CustomSnackBar.showSuccess(context, "Succès ! 🎉");
              },
              child: Text("Afficher SnackBar"),
            ),
          ],
        ),
      ),
    );
  }
}
