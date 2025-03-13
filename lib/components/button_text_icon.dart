import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/styles/style.dart';

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
        width: 100, // Ajustez la largeur si nécessaire
        height: 100, // Ajustez la hauteur si nécessaire
        decoration: BoxDecoration(
          color: Style.styles[AppStyle.thirdColor], // Couleur de fond
          borderRadius: BorderRadius.circular(20), // Coins arrondis
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                child: Column(
                  // clipBehavior: Clip.none, // Permet de faire sortir l'image
                  children: [
                    SvgPicture.asset(
                      svgPath,
                      height: 50, // Taille minimale de l'image
                      width: 50, // Taille minimale de l'image
                    ),
                    SizedBox(height: 5),
                    Text(
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      text,
                      style: TextStyle(
                        color: Colors.black, // Couleur du texte
                        fontSize: 10, // Taille du texte
                        fontWeight: FontWeight.bold, // Gras
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
