import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealci/utils/styles/style.dart';

class FridgeRaitingChart extends StatelessWidget {
  final double progressA;
  final double progressB;
  final double progressC;

  const FridgeRaitingChart({
    required this.progressA,
    required this.progressB,
    required this.progressC,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Logo à gauche
          Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: SvgPicture.asset(
                CustomMealciAsset.fridgeIcon,
              )),
          const SizedBox(width: 16),

          // Barres de progression à droite
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildProgressRow('A', Colors.green, progressA),
                const SizedBox(height: 12),
                buildProgressRow('B', Colors.orange, progressB),
                const SizedBox(height: 12),
                buildProgressRow('C', Colors.red, progressC),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Fonction pour construire chaque ligne de progression
  Widget buildProgressRow(String label, Color color, double progress) {
    return Row(
      children: [
        // Badge circulaire
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),

        // Barre de progression
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: LinearProgressIndicator(
              value: progress, // Valeur de la progression
              color: color,
              backgroundColor: Colors.grey[200], // Couleur de fond
              minHeight: 12, // Hauteur de la barre
            ),
          ),
        ),
      ],
    );
  }
}
