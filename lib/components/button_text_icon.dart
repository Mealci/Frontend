import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class ButtonTextIcon extends StatelessWidget {
  final String text;
  final String svgPath;
  final VoidCallback? onPressed;

  const ButtonTextIcon({
    super.key,
    required this.text,
    required this.svgPath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 120, // Ajustez la largeur si nécessaire
        height: 120, // Ajustez la hauteur si nécessaire
        decoration: BoxDecoration(
          color: const Color(0xFFDCC6F5), // Couleur de fond violet
          borderRadius: BorderRadius.circular(20), // Coins arrondis
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Column(
                // clipBehavior: Clip.none, // Permet de faire sortir l'image
                children: [
                  SvgPicture.asset(
                    svgPath,
                    height: 60, // Taille minimale de l'image
                    width: 60, // Taille minimale de l'image
                  ),

                  Text(
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    text,
                    style: const TextStyle(
                      color: Colors.black, // Couleur du texte
                      fontSize: 16, // Taille du texte
                      fontWeight: FontWeight.bold, // Gras
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
