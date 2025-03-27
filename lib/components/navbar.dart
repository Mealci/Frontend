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
    final screenHeight = MediaQuery.of(context).size.height;
    final textScale = MediaQuery.textScaleFactorOf(context);

    return Container(
      height: screenHeight * 0.1,
      decoration: BoxDecoration(
        color: const Color(0xFFC1ADFF),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
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
        labels: const ["Map", "Tracker", "Mealci", "Calendar", "Chart"],
        icons: const [
          Icons.map,
          Icons.menu_book_rounded,
          Icons.food_bank,
          Icons.calendar_month_rounded,
          Icons.bar_chart_rounded,
        ],
        tabSize: screenHeight * 0.07,
        tabBarHeight: screenHeight * 0.08,
        textStyle: TextStyle(
          fontSize: screenHeight * 0.016 * textScale,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        tabBarColor: Colors.transparent,
        tabIconColor: Colors.white,
        tabIconSize: screenHeight * 0.035, // Scale icon size
        tabIconSelectedSize: screenHeight * 0.032,
        tabSelectedColor: const Color(0xFFE3BDFF),
        tabIconSelectedColor: Colors.white,
        onTabItemSelected: onTabSelected,
      ),
    );
  }
}
