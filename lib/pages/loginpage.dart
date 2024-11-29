import 'package:flutter/material.dart';
import '../utils/styles/style.dart';
import '../utils/I18N/logini18ntranslation.dart';
import '../components/inputfieldloginregister.dart';
import '../components/buttonloginregister.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/env/environnementvariable.dart';
import '../utils/logger/logger.dart';

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
    const String loginPath = '/login';
    final Uri loginUri = Uri.parse('${EnvironnementVariable.apiUrl}$loginPath');

    try {
      final response = await http.post(
        loginUri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(loginData),
      );

      if (response.statusCode == 200) {
        _logger.info('Connexion réussie');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Connexion réussie')),
        );

        // Redirection ou autre action après connexion
      } else {
        _logger.severe('Erreur: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: ${response.body}')),
        );
      }
    } catch (error) {
      _logger.severe('Erreur lors de la connexion : $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la connexion : $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Style.styles[AppStyle.backgroundColorGL],
              Style.styles[AppStyle.backgroundColor],
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: SingleChildScrollView(
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
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 90.0,
                      backgroundImage: AssetImage(CustomMealciAsset.logo),
                    ),
                  ),
                  const SizedBox(height: 62),

                  // Champs de saisie
                  InputField(
                    label: LoginPageTranslation.email,
                    map: LoginPageI18n.loginPageTranslations,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20),
                  InputField(
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
      ),
    );
  }
}
