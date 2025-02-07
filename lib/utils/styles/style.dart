import 'package:flutter/material.dart';

enum AppStyle {
  primaryColor,
  secondaryColor,
  thirdColor,
  backgroundColor,
  backgroundColorGL,
  textColor,
  buttonTextStyle,
  boxShadowColor
}

class Style {
  static const Map<AppStyle, dynamic> styles = {
    //colors
    AppStyle.primaryColor: Color.fromARGB(255, 163, 134, 250),
    AppStyle.secondaryColor: Color(0xFF5A23B1),
    AppStyle.thirdColor: Color(0xFFDCC6F5),
    AppStyle.backgroundColor: Color(0xFFFFF3FF),
    AppStyle.textColor: Colors.white,
    AppStyle.boxShadowColor: Color.fromRGBO(0, 0, 0, 0.5),

    //text styles
    AppStyle.buttonTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  };
}

class CustomMealciAsset {
  static const String logo = 'assets/images/logo.png';
  static const String logoWhite = 'assets/svg/login_third_icon.svg';

  static const String profileIcon = 'assets/svg/profile_icon.svg';
  static const String fridgeIcon = 'assets/svg/fridge_icon.svg';
  static const String drinkIcon = 'assets/svg/drink_icon.svg';
  static const String milkIcon = 'assets/svg/milk_icon.svg';
  static const String fruitIcon = 'assets/svg/fruit_icon.svg';
  static const String legumineuseIcon = 'assets/svg/legumineuse_icon.svg';
  static const String legumeIcon = 'assets/svg/legume_icon.svg';
  static const String feculentIcon = 'assets/svg/feculent_icon.svg';
  static const String sugarIcon = 'assets/svg/sugar_icon.svg';
  static const String spicyIcon = 'assets/svg/spicy_icon.svg';
  static const String oilIcon = 'assets/svg/oil_icon.svg';
  static const String junkFoodIcon = 'assets/svg/junk_food_icon.svg';
  static const String dietIcon = 'assets/svg/aliment_dietetique_icon.svg';
  static const String meatIcon = 'assets/svg/meat_icon.svg';
  static const String fishIcon = 'assets/svg/fish_icon.svg';
  static const String toiletIcon = 'assets/svg/toilet_icon.svg';
}
