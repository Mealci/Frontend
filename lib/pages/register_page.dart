import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mealci/services/auth_service.dart';
import '../utils/i18N/register_i18n_translation.dart';
import '../components/input_field_login_register.dart';
import '../components/button_login_register.dart';
import '../utils/i18N/i18n.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

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
                            RegisterPageI18n.registerPageTranslations,
                            RegisterPageTranslation.title1) as String,
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
                                  RegisterPageI18n.registerPageTranslations,
                                  RegisterPageTranslation.title2) as String,
                              textStyle: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Voltaire',
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
                  label: RegisterPageTranslation.email,
                  map: RegisterPageI18n.registerPageTranslations,
                  controller: _emailController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: RegisterPageTranslation.password,
                  map: RegisterPageI18n.registerPageTranslations,
                  controller: _passwordController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: RegisterPageTranslation.firstName,
                  map: RegisterPageI18n.registerPageTranslations,
                  controller: _firstNameController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: RegisterPageTranslation.lastName,
                  map: RegisterPageI18n.registerPageTranslations,
                  controller: _lastNameController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: RegisterPageTranslation.age,
                  map: RegisterPageI18n.registerPageTranslations,
                  controller: _ageController,
                ),
                const SizedBox(height: 20),

                Buttonloginregister(
                  label: RegisterPageTranslation.register,
                  map: RegisterPageI18n.registerPageTranslations,
                  onPressed: () {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final firstName = _firstNameController.text;
                    final lastName = _lastNameController.text;
                    final age = _ageController.text;

                    AuthService().register(
                      context,
                      firstName,
                      lastName,
                      password,
                      email,
                      age,
                    );
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
