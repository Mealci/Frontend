import 'package:flutter/material.dart';

enum AppStyle {
    primaryColor,
    secondaryColor,
    backgroundColor,
    backgroundColorGL,
    textColor,
    buttonColor,
    buttonTextStyle,
    boxShadowColor
}

class Style {
    static const Map<AppStyle, dynamic> styles = {
      //colors
      AppStyle.primaryColor: Color.fromRGBO(255, 205, 255, 100),
      AppStyle.secondaryColor: Color.fromRGBO(193, 173, 255, 100),
      AppStyle.backgroundColorGL: Color.fromRGBO(255, 205, 255, 100),
      AppStyle.backgroundColor: Color.fromARGB(255, 229, 169, 250),
      AppStyle.textColor: Color.fromRGBO(62, 62, 62, 100),
      AppStyle.boxShadowColor: Color.fromRGBO(0, 0, 0, 0.5),
      AppStyle.buttonColor: Color(0xFF9B7CC4),
      
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
}