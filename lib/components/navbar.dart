import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.controller,
    required this.onTabSelected,
  });

  final MotionTabBarController controller;
  final Function(int) onTabSelected;

  @override
  Widget build(BuildContext context) {
    // Récupérer les dimensions de l'écran
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScale = MediaQuery.textScaleFactorOf(context);

    return Positioned(
      left: screenWidth * 0.05, // 5% de la largeur de l'écran
      right: screenWidth * 0.05,
      bottom: screenHeight * 0.02, // 2% de la hauteur de l'écran
      child: Container(
        height: screenHeight * 0.1, // 10% de la hauteur de l'écran
        decoration: BoxDecoration(
          color: const Color(0xFFC1ADFF),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: MotionTabBar(
          controller: controller,
          initialSelectedTab: "Mealci",
          useSafeArea: false,
          labels: const ["Recipes", "Map", "Mealci", "Calendar", "Chart"],
          icons: const [
            Icons.menu_book_rounded,
            Icons.map,
            Icons.food_bank,
            Icons.calendar_month_rounded,
            Icons.bar_chart_rounded,
          ],
          tabSize: screenHeight * 0.07, // Taille proportionnelle à la hauteur
          tabBarHeight: screenHeight * 0.08, // Hauteur proportionnelle
          textStyle: TextStyle(
            fontSize: 12 * textScale,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          tabBarColor: Colors.transparent,
          tabIconColor: Colors.white,
          tabIconSize: screenHeight * 0.035, // Adapter la taille des icônes
          tabIconSelectedSize: screenHeight * 0.032,
          tabSelectedColor: const Color(0xFFE3BDFF),
          tabIconSelectedColor: Colors.white,
          onTabItemSelected: onTabSelected,
        ),
      ),
    );
  }
}
