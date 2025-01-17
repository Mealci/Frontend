import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../utils/I18N/register_i18n_translation.dart';
import '../components/input_field_login_register.dart';
import '../components/button_login_register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/env/environnementvariable.dart';
import '../utils/logger/logger.dart';
import '../utils/I18N/i18n.dart';
import '../utils/secure_storage/secure_storage_management.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static final MealciLogger _logger = MealciLogger('RegisterPage');

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  // Fonction d'inscription
  Future<void> registerUser(Map<String, String> userData) async {
    const String registerPath = '/auth/register';
    final Uri registerUri =
        Uri.parse('${EnvironnementVariable.apiUrl}$registerPath');

    try {
      final response = await http.post(
        registerUri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
      );

      if (response.statusCode == 200) {
        final String responseBody = response.body;
        final SecureStorageManagement secureStorageManagement =
            SecureStorageManagement();
        await secureStorageManagement.writeData('token_jwt', responseBody);

        _logger.info('Utilisateur enregistré avec succès');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Utilisateur enregistré avec succès')),
        );

        Navigator.pushNamed(context, '/home');
      } else {
        _logger.severe('Erreur: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: ${response.body}')),
        );
      }
    } catch (error) {
      _logger.severe('Erreur lors de l\'enregistrement : $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'enregistrement : $error')),
      );
    }
  }

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
                          fontFamily: 'Voltaire',
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
                    // Récupérer les données des champs
                    final Map<String, String> userData = {
                      'email': _emailController.text,
                      'password': _passwordController.text,
                      'firstName': _firstNameController.text,
                      'lastName': _lastNameController.text,
                      'age': _ageController.text,
                    };

                    // Appeler la méthode registerUser
                    registerUser(userData);
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
