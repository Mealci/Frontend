import 'package:flutter/material.dart';
import 'package:mealci/utils/i18N/i18n.dart';
import 'package:mealci/utils/styles/style.dart';
import 'package:mealci/models/field_type.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final Map<dynamic, String> map;
  final dynamic label;
  final FieldType fieldType; // Utiliser un type de champ

  const CustomTextField({
    super.key,
    required this.controller,
    required this.map,
    required this.label,
    this.fieldType = FieldType.text, // Type par défaut : text
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();

    // Écoute les changements de focus et met à jour l'état
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Prend toute la largeur disponible
      height: 60,
      decoration: BoxDecoration(
        color: focusNode.hasFocus
            ? Colors.white // Couleur de fond au focus
            : Color(Style.styles[AppStyle.primaryColor].value ??
                Colors.white), // Couleur de fond standard
        borderRadius: BorderRadius.circular(40), // Coins arrondis
        boxShadow: focusNode.hasFocus
            ? [
                BoxShadow(color: Colors.green.withAlpha(30), blurRadius: 10)
              ] // Ombre visible au focus
            : [],
        border: Border.all(
          color: focusNode.hasFocus
              ? Color(
                  Style.styles[AppStyle.secondaryColor].value ?? Colors.green)
              : Color(Style.styles[AppStyle.primaryColor].value ?? Colors.black)
                  .withAlpha(30), // Couleur de la bordure
          width: 2.5, // Bordure plus épaisse au focus
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Icône alignée à gauche
          Positioned(
            left: 30,
            child: Icon(
              Icons.edit, // Icône représentant un champ de texte
              color: focusNode.hasFocus
                  ? Color(Style.styles[AppStyle.secondaryColor].value ??
                      Colors.green)
                  : Color(
                      Style.styles[AppStyle.textColor].value ?? Colors.grey),
              size: 24, // Taille de l'icône
            ),
          ),

          // Champ de texte centré
          Center(
            child: TextField(
              controller: widget.controller,
              textAlign: TextAlign.center, // Centrer le texte saisi
              style: TextStyle(
                color: focusNode.hasFocus ? Colors.black : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold, // Couleur du texte
              ),
              obscureText: widget.fieldType ==
                  FieldType
                      .password, // Masque le texte si c'est un mot de passe
              keyboardType: widget.fieldType == FieldType.email
                  ? TextInputType.emailAddress
                  : TextInputType.text, // Utilisation du type de clavier adapté
              decoration: InputDecoration(
                border: InputBorder.none, // Pas de bordure interne
                hintText: I18n.getTranslation(widget.map, widget.label) ??
                    '', // Texte d'indication
                hintStyle: TextStyle(
                  color: Color(Style.styles[AppStyle.textColor].value ??
                      Colors.grey), // Couleur du texte d'indication
                ),
              ),
              focusNode: focusNode, // Ajout du focusNode pour le focus visuel
              onChanged: (text) {
                if (widget.fieldType == FieldType.email) {
                  // Vérification de la syntaxe de l'email
                  final emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
                  if (!emailRegex.hasMatch(text)) {
                    // Ajouter une logique ici pour afficher un message d'erreur si nécessaire
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
