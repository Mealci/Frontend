import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mealci/services/auth_service.dart';
import '../utils/i18N/login_i18n_translation.dart';
import '../components/input_field_login_register.dart';
import '../components/button_login_register.dart';
import '../utils/i18N/i18n.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: I18n.getTranslation(
                            LoginPageI18n.loginPageTranslations,
                            LoginPageTranslation.title1) as String,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                        ),
                      ),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.baseline,
                        baseline: TextBaseline.alphabetic,
                        child: AnimatedTextKit(
                          animatedTexts: [
                            ColorizeAnimatedText(
                              I18n.getTranslation(
                                  LoginPageI18n.loginPageTranslations,
                                  LoginPageTranslation.title2) as String,
                              textStyle: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway',
                              ),
                              colors: [
                                const Color.fromARGB(255, 163, 134, 250),
                                const Color(0xFF5A23B1),
                                Colors.purple,
                              ],
                              speed: const Duration(milliseconds: 800),
                            ),
                          ],
                          isRepeatingAnimation: true,
                          totalRepeatCount: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),

                // Champs de saisie
                CustomTextField(
                  label: LoginPageTranslation.email,
                  map: LoginPageI18n.loginPageTranslations,
                  controller: _emailController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: LoginPageTranslation.password,
                  map: LoginPageI18n.loginPageTranslations,
                  controller: _passwordController,
                ),
                const SizedBox(height: 20),

                Buttonloginregister(
                  label: LoginPageTranslation.login,
                  map: LoginPageI18n.loginPageTranslations,
                  onPressed: () {
                    final username = _emailController.text;
                    final password = _passwordController.text;
                    AuthService().login(context, username, password);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
