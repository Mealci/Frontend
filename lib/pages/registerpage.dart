import 'package:flutter/material.dart';
import '../utils/styles/style.dart';
import '../utils/I18N/registeri18ntranslation.dart';
import '../components/inputfieldloginregister.dart';
import '../components/buttonloginregister.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/env/environnementvariable.dart';
import '../utils/logger/logger.dart';


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
    const String registerPath = '/register';
    final Uri registerUri = Uri.parse('${EnvironnementVariable.apiUrl}$registerPath');

    try {
      final response = await http.post(
        registerUri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
      );

      if (response.statusCode == 200) {
        _logger.info('Utilisateur enregistré avec succès');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Utilisateur enregistré avec succès')),
        );
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
                  InputField(label: RegisterPageTranslation.email, map: RegisterPageI18n.registerPageTranslations, controller: _emailController),
                  const SizedBox(height: 20),
                  InputField(label: RegisterPageTranslation.password, map: RegisterPageI18n.registerPageTranslations, controller: _passwordController),
                  const SizedBox(height: 20),
                  InputField(label: RegisterPageTranslation.firstName, map: RegisterPageI18n.registerPageTranslations, controller: _firstNameController),
                  const SizedBox(height: 20),
                  InputField(label: RegisterPageTranslation.lastName, map: RegisterPageI18n.registerPageTranslations, controller: _lastNameController),
                  const SizedBox(height: 20),
                  InputField(label: RegisterPageTranslation.age, map: RegisterPageI18n.registerPageTranslations, controller: _ageController),
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