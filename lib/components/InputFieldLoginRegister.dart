import 'package:flutter/material.dart';
import 'package:mealci/utils/I18N/I18N.dart';
import 'package:mealci/utils/I18N/RegisterI18nTranslation.dart';

class InputField extends StatelessWidget {
  const InputField({super.key, required this.label});

  final dynamic label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: double.infinity, // Prend toute la largeur disponible
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFC1A4F7), // Couleur du champ de texte (violet clair)
        borderRadius: BorderRadius.circular(40), // Coins arrondis
      ),
      child: TextField(
        textAlign: TextAlign.center, // Centrer le texte saisi
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: I18n.getTranslation(RegisterPageI18n.registerPageTranslations, label) ?? '',
          hintStyle: const TextStyle(
            color: Color(0xFF000000), // Couleur du texte (noir)
          ),
        ),
      ),
    );
  }
}