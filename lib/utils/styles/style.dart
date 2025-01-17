import 'package:flutter/material.dart';

enum AppStyle {
  primaryColor,
  secondaryColor,
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
  static const String logoWhite = 'assets/svg/tst.svg';
}
