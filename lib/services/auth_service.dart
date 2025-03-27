import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mealci/components/custom_snak_bar.dart';
import 'package:mealci/utils/env/environnementvariable.dart';
import 'package:mealci/utils/logger/logger.dart';
import 'package:mealci/utils/secure_storage/secure_storage_management.dart';

class AuthService {
  static final MealciLogger _logger = MealciLogger('LoginPage');

  Future<void> login(
      BuildContext context, String email, String password) async {
    const String loginPath = '/auth/login';
    final Uri loginUri = Uri.parse('${EnvironnementVariable.apiUrl}$loginPath');

    try {
      final response = await http.post(
        loginUri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        _logger.info('Connexion réussie');

        final String responseBody = response.body;

        final SecureStorageManagement secureStorageManagement =
            SecureStorageManagement();
        await secureStorageManagement.writeData('token_jwt', responseBody);

        CustomSnackBar.showSuccess(context, "Connexion réussie");

        Navigator.pushNamed(context, '/home');
      } else {
        _logger.severe('Erreur du serveur: ${response.statusCode}');

        final errorMessage =
            json.decode(response.body)['message'] ?? 'Erreur inconnue';

        CustomSnackBar.showError(context, errorMessage);
      }
    } catch (error, stackTrace) {
      _logger.severe('Erreur lors de la connexion: $error , $stackTrace');
      CustomSnackBar.showError(context, 'Erreur lors de la connexion');
    }
  }

  Future<void> register(
    BuildContext context,
    String firstName,
    String lastName,
    String password,
    String email,
    String age,
  ) async {
    const String registerPath = '/auth/register';
    final Uri registerUri =
        Uri.parse('${EnvironnementVariable.apiUrl}$registerPath');

    try {
      final response = await http.post(
        registerUri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'firstName': firstName,
            'lastName': lastName,
            'password': password,
            'email': email,
            'age': age,
          },
        ),
      );

      if (response.statusCode == 200) {
        final String responseBody = response.body;
        final SecureStorageManagement secureStorageManagement =
            SecureStorageManagement();
        await secureStorageManagement.writeData('token_jwt', responseBody);

        _logger.info('Utilisateur enregistré avec succès');
        CustomSnackBar.showSuccess(context, 'Utilisateur enregistré avec succès');

        Navigator.pushNamed(context, '/home');
      } else {
        _logger.severe('Erreur: ${response.body}');
        CustomSnackBar.showError(context, 'Erreur: ${response.body}');
      }
    } catch (error) {
      _logger.severe('Erreur lors de l\'enregistrement : $error');
      CustomSnackBar.showError(context, 'Erreur lors de l\'enregistrement');
    }
  }
}
