import 'package:flutter/material.dart';
import 'package:mealci/components/ButtonPadding.dart';
import '../utils/styles/style.dart';
import '../utils/I18N/logini18ntranslation.dart';

class LoginThirdPage extends StatelessWidget {
  const LoginThirdPage({super.key});

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
                  const ButtonPadding(label: LoginThirdPageTranslation.login, map: LoginThirdPageI18n.loginThirdPageTranslation, padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15), icon: 0x0),
                  const ButtonPadding(label: LoginThirdPageTranslation.register, map: LoginThirdPageI18n.loginThirdPageTranslation, padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15), icon: 0x0),
                  const ButtonPadding(label: LoginThirdPageTranslation.apple, map: LoginThirdPageI18n.loginThirdPageTranslation, padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15), icon: 0xf04be),
                  const ButtonPadding(label: LoginThirdPageTranslation.google, map: LoginThirdPageI18n.loginThirdPageTranslation, padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15), icon: 0xe2ce),
                  const ButtonPadding(label: LoginThirdPageTranslation.facebook, map: LoginThirdPageI18n.loginThirdPageTranslation, padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15), icon: 0xe255),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
