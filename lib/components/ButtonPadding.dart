import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mealci/utils/I18N/I18n.dart';
import 'package:mealci/utils/styles/style.dart';

class ButtonPadding extends StatelessWidget {
  final dynamic label;
  final Map<dynamic, String> map;
  final IconData icon;
  final VoidCallback? onPressed;  // Notez que `VoidCallback` est maintenant nullable

  const ButtonPadding({
    required this.label,
    required this.map,
    this.icon = Icons.abc_rounded,
    this.onPressed,  // Il n'est plus nécessaire de donner une valeur par défaut ici
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFC1A4F7), // Couleur du champ de texte (violet clair)
        borderRadius: BorderRadius.circular(40), // Coins arrondis
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC1A4F7),
        ),
        onPressed: onPressed ?? () {},  // Si `onPressed` est nul, une fonction vide est utilisée
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Icône alignée à gauche
            Positioned(
              left: 15,
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),

            // Texte centré
            Center(
              child: Text(
                I18n.getTranslation(map, label) ?? '',
                style: Style.styles[AppStyle.buttonTextStyle],
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
