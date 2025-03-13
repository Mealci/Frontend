import 'package:flutter/material.dart';

class AdaptativeSquare extends StatelessWidget {
  final String data;
  final Color backgroundColor;
  final bool isSquare;

  const AdaptativeSquare({
    Key? key,
    required this.data,
    required this.backgroundColor,
    required this.isSquare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Contenu de la carte avec un padding et une couleur de fond
    final cardContent = Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          data,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

    // Si isSquare est vrai, on force un aspect ratio 1 (carré)
    if (isSquare) {
      return AspectRatio(
        aspectRatio: 1,
        child: cardContent,
      );
    } else {
      // Pour un rectangle, on prend toute la largeur disponible
      return Container(
        width: double.infinity,
        child: cardContent,
      );
    }
  }
}
