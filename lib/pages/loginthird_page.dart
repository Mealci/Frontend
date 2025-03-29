import 'package:flutter/material.dart';
import 'package:mealci/components/custom_snak_bar.dart';
import 'package:mealci/utils/i18N/i18n.dart';
import 'package:mealci/utils/i18N/login_i18n_translation.dart';
import '../components/button_padding.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: I18n.getTranslation(
                          LoginThirdPageI18n.loginThirdPageTranslation,
                          LoginThirdPageTranslation.welcomeTo) as String,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText(
                            I18n.getTranslation(
                                LoginThirdPageI18n.loginThirdPageTranslation,
                                LoginThirdPageTranslation.mealSCI) as String,
                            textStyle: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway',
                            ),
                            colors: [
                              const Color.fromARGB(255, 163, 134, 250),
                              const Color(0xFF5A23B1),
                              Colors.purple,
                            ],
                            speed: const Duration(milliseconds: 2000),
                          ),
                        ],
                        isRepeatingAnimation: true,
                        repeatForever: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              // Bouton Login
              ButtonPadding(
                icon: Icons.login,
                label: LoginThirdPageTranslation.login,
                map: LoginThirdPageI18n.loginThirdPageTranslation,
                onPressed: () => Navigator.pushNamed(context, '/login'),
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

              // Séparation avec "or"
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
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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

              // Boutons tiers (Apple, Google, Facebook)
              ButtonPadding(
                  icon: Icons.apple,
                  label: LoginThirdPageTranslation.apple,
                  map: LoginThirdPageI18n.loginThirdPageTranslation,
                  onPressed: () => CustomSnackBar.showInfo(context,
                      "L'authentification Apple n'est pas encore disponible")),
              const SizedBox(height: 20),

              ButtonPadding(
                  icon: Icons.g_mobiledata,
                  label: LoginThirdPageTranslation.google,
                  map: LoginThirdPageI18n.loginThirdPageTranslation,
                  onPressed: () => CustomSnackBar.showInfo(context,
                      "L'authentification Google n'est pas encore disponible")),
              const SizedBox(height: 20),

              ButtonPadding(
                icon: Icons.facebook,
                label: LoginThirdPageTranslation.facebook,
                map: LoginThirdPageI18n.loginThirdPageTranslation,
                onPressed: () => CustomSnackBar.showInfo(context,
                    "L'authentification Facebook n'est pas encore disponible"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
