import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mealci/utils/I18N/I18n.dart';
import '../utils/style.dart';
import '../utils/I18N/RegisterI18nTranslation.dart';
import '../components/InputFieldLoginRegister.dart';
import '../components/ButtonLoginRegister.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,  // Début du gradient en bas
            end: Alignment.topCenter,      // Fin du gradient en haut
            colors: [
              Style.styles[AppStyle.backgroundColorGL], // Couleur foncée en haut (violet)
              Style.styles[AppStyle.backgroundColor] // Couleur claire en bas (violet)
            ],
          ),
        ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Style.styles[AppStyle.boxShadowColor],
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 5), // Ombre décalée vers le bas
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 90.0,
                      backgroundImage: AssetImage(CustomMealciAsset.logo),
                    ),
                  ),
                  const SizedBox(height: 62), // Espacement entre le logo et les champs de texte

                  // Champs de saisie
                  const InputField(label: RegisterPageTranslation.email),
                  const SizedBox(height: 20),
                  const InputField(label: RegisterPageTranslation.password),
                  const SizedBox(height: 20),
                  const InputField(label: RegisterPageTranslation.confirmPassword),
                  const SizedBox(height: 20),
                  const InputField(label: RegisterPageTranslation.screenName),
                  const SizedBox(height: 20),

                  const Buttonloginregister(label: RegisterPageTranslation.register, map: RegisterPageI18n.registerPageTranslations),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
