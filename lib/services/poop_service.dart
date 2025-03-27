import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mealci/models/poop_model.dart';
import 'package:mealci/utils/env/environnementvariable.dart';
import 'package:mealci/utils/logger/logger.dart';
import 'package:mealci/utils/secure_storage/secure_storage_management.dart';

class PoopService {
  static final MealciLogger _logger = MealciLogger('LoginPage');
  final SecureStorageManagement secureStorageManagement =
      SecureStorageManagement();

  Future<void> createPoop(BuildContext context, Poop poop) async {
    const String loginPath = '/poopMonitoring/create';
    final Uri uri = Uri.parse('${EnvironnementVariable.apiUrl}$loginPath');

    // get the token from secure storage
    final String? token = await secureStorageManagement.readData('token_jwt');
    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(poop.toJson()),
      );

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/home');
      } else {
        _logger.severe('Erreur du serveur: ${response.statusCode}');

        final errorMessage = json.decode(response.body);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $errorMessage')),
        );
      }
    } catch (error, stackTrace) {
      _logger.severe('Erreur lors de la connexion: $error , $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Erreur lors de la connexion : ${error.toString()}')),
      );
    }
  }
}
