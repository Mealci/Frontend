import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../utils/I18N/login_i18n_translation.dart';
import '../components/input_field_login_register.dart';
import '../components/button_login_register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/env/environnementvariable.dart';
import '../utils/logger/logger.dart';
import '../utils/I18N/i18n.dart';
import '../utils/secure_storage/secure_storage_management.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static final MealciLogger _logger = MealciLogger('LoginPage');

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

// Fonction de connexion
  Future<void> loginUser(Map<String, String> loginData) async {
    const String loginPath = '/auth/login';
    final Uri loginUri = Uri.parse('${EnvironnementVariable.apiUrl}$loginPath');

    try {
      // Envoyer la requête POST
      final response = await http.post(
        loginUri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(loginData),
      );

      // Vérifier le code de statut de la réponse
      if (response.statusCode == 200) {
        _logger.info('Connexion réussie');

        // Décoder la réponse
        final String responseBody = response.body;

        final SecureStorageManagement secureStorageManagement =
            SecureStorageManagement();
        await secureStorageManagement.writeData('token_jwt', responseBody);

        // Afficher un message de succès
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Connexion réussie')),
        );

        // Naviguer vers la page suivante
        Navigator.pushNamed(context, '/home');
      } else {
        // Gérer les erreurs du serveur
        _logger.severe('Erreur du serveur: ${response.statusCode}');
        final errorMessage =
            json.decode(response.body)['message'] ?? 'Erreur inconnue';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $errorMessage')),
        );
      }
    } catch (error, stackTrace) {
      // Gérer les exceptions (erreurs réseau, JSON, etc.)
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Erreur lors de la connexion : ${error.toString()}')),
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
                    // Récupérer les données des champs
                    final Map<String, String> loginData = {
                      'email': _emailController.text,
                      'password': _passwordController.text,
                    };

                    // Appeler la méthode loginUser
                    loginUser(loginData);
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
