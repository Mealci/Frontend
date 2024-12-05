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
    return Positioned(
      left: 20,
      right: 20,
      bottom: 20,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFC1ADFF),
          borderRadius: BorderRadius.circular(30),
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
            Icons.bar_chart_rounded
          ],
          tabSize: 50,
          tabBarHeight: 55,
          textStyle: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          tabBarColor: Colors.transparent,
          tabIconColor: Colors.white,
          tabIconSize: 28.0,
          tabIconSelectedSize: 26.0,
          tabSelectedColor: const Color(0xFFE3BDFF),
          tabIconSelectedColor: Colors.white,
          onTabItemSelected: onTabSelected,
        ),
      ),
    );
  }
}
