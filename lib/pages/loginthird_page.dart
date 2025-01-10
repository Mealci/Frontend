import 'package:flutter/material.dart';
import 'package:mealci/utils/I18N/i18n.dart';
import 'package:mealci/utils/I18N/login_i18n_translation.dart';
import '../utils/styles/style.dart';
import '../components/button_padding.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginThirdPage extends StatelessWidget {
  const LoginThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // text "Welcome to MealSCI"
              Text(
                I18n.getTranslation(
                    LoginThirdPageI18n.loginThirdPageTranslation,
                    LoginThirdPageTranslation.welcomeToMealci) as String,
                style: TextStyle(
                  color: Color(
                      Style.styles[AppStyle.buttonColor].value ?? Colors.black),
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Voltaire',
                ),
              ),
              const SizedBox(height: 50),

              // Bouton Login
              ButtonPadding(
                icon: Icons.login,
                label: LoginThirdPageTranslation.login,
                map: LoginThirdPageI18n.loginThirdPageTranslation,
                onPressed: () => // go to login page
                    Navigator.pushNamed(context, '/login'),
              ),
              const SizedBox(height: 20),

              // Bouton Register
              ButtonPadding(
                icon: Icons.app_registration,
                label: LoginThirdPageTranslation.register,
                map: LoginThirdPageI18n.loginThirdPageTranslation,
                onPressed: () => Navigator.pushNamed(context, '/register'),
              ),
              const SizedBox(height: 20),

              // make separation between buttons using 2 divider and Text "or"
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      I18n.getTranslation(
                          LoginThirdPageI18n.loginThirdPageTranslation,
                          LoginThirdPageTranslation.or) as String,
                      style: TextStyle(
                        color: Color(
                            Style.styles[AppStyle.primaryColor].value ??
                                Colors.black),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Voltaire',
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Bouton Apple
              const ButtonPadding(
                  icon: Icons.apple,
                  label: LoginThirdPageTranslation.apple,
                  map: LoginThirdPageI18n.loginThirdPageTranslation),
              const SizedBox(height: 20),

              // Bouton Google
              const ButtonPadding(
                icon: Icons.g_mobiledata,
                label: LoginThirdPageTranslation.google,
                map: LoginThirdPageI18n.loginThirdPageTranslation,
              ),
              const SizedBox(height: 20),

              // Bouton Facebook
              ButtonPadding(
                icon: Icons.facebook,
                label: LoginThirdPageTranslation.facebook,
                map: LoginThirdPageI18n.loginThirdPageTranslation,
                onPressed: () =>
                    Navigator.pushNamed(context, '/textRecognitionScreen'),
              ),

              // Ajouter l'image SVG avec Stack pour sortir légèrement de l'écran
              const SizedBox(height: 50), // Ajout d'un espace avant le SVG

              // Container avec une taille définie pour résoudre le problème de Stack
              SizedBox(
                height:
                    60, // Taille suffisante pour contenir l'image et la sortie
                child: Stack(
                  clipBehavior: Clip.none, // Permet de faire sortir l'image
                  children: [
                    Positioned(
                      bottom:
                          -160, // Décaler l'image de 200 px en dehors de l'écran
                      left: 0,
                      right: 0,
                      child: SvgPicture.asset(
                        CustomMealciAsset.logoWhite,
                        height: 300, // Taille minimale de l'image
                        width: 300, // Taille minimale de l'image
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30), // Un peu d'espace après le SVG
            ],
          ),
        ),
      ),
    );
  }
}
