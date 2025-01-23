import 'package:flutter/material.dart';

class FeedFridgeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FeedFridgeButton({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(1500, 50), // Taille minimale du bouton
        backgroundColor: Colors.purple[200], // Couleur de fond
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Bordures arrondies
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), // Padding du bouton
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min, // Taille adaptée au contenu
        children: [
          Text(
            'Nourrissez le frigo',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Couleur du texte
            ),
          ),
          SizedBox(width: 16), // Espacement entre le texte et l'icône
          Icon(
            size: 30, // Taille de l'icône
            Icons.add, // Icône carotte
            color: Colors.black, // Couleur de l'icône
          ),
        ],
      ),
    );
  }
}