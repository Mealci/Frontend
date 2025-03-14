import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealci/components/save_poop_button.dart';
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
            const Spacer(), // Ajoute un espace entre le titre et les éléments centraux
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Ajouter un caca'),
                          content: const Text('Voulez-vous ajouter un caca ?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Non'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Oui'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const Spacer(), // Ajoute un espace en bas pour équilibrer la mise en page
          ],
        ),
      ),
    );
  }
}
