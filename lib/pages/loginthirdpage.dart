import 'package:flutter/material.dart';
import 'package:mealci/utils/I18N/login_i18n_translation.dart';
import '../utils/styles/style.dart';
import '../components/button_padding.dart';

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
              Style.styles[AppStyle.backgroundColor],  // Couleur claire en bas (violet)
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo circulaire
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

                // Bouton Apple
                const ButtonPadding(
                  icon: Icons.apple,
                  label: LoginThirdPageTranslation.apple,
                  map: LoginThirdPageI18n.loginThirdPageTranslation
                  ),
                const SizedBox(height: 20),

                // Bouton Google
                const ButtonPadding(
                  icon: Icons.g_mobiledata, 
                  label: LoginThirdPageTranslation.google,
                  map: LoginThirdPageI18n.loginThirdPageTranslation,
                ),
                const SizedBox(height: 20),

                // Bouton Facebook
                const ButtonPadding(
                  icon: Icons.facebook,
                  label: LoginThirdPageTranslation.facebook,
                  map: LoginThirdPageI18n.loginThirdPageTranslation,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
