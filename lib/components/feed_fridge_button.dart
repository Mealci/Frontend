import 'package:flutter/material.dart';
import '../utils/styles/style.dart';

class FeedFridgeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FeedFridgeButton({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Obtenir la largeur de l'écran
    double screenWidth = MediaQuery.of(context).size.width;

    bool isSmallScreen = screenWidth <= 420; // iPhone SE (1ère génération)

    return Align(
      alignment: isSmallScreen ? Alignment.centerRight : Alignment.center,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(isSmallScreen ? 40 : 1000, 35),
          backgroundColor: Style.styles[AppStyle.primaryColor],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 8 : 24,
            vertical: 16,
          ),
        ),
        child: isSmallScreen
            ? const Icon(
                Icons.add,
                size: 20,
                color: Colors.white,
              )
            : const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Nourrissez le frigo',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 16),
                  Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  ),
                ],
              ),
      ),
    );
  }
}
