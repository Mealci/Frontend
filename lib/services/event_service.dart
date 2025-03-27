import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mealci/utils/env/environnementvariable.dart';
import 'package:mealci/utils/logger/logger.dart';
import 'package:mealci/utils/secure_storage/secure_storage_management.dart';

class EventService {
  static final MealciLogger _logger = MealciLogger('LoginPage');
  final SecureStorageManagement secureStorageManagement =
      SecureStorageManagement();

  Future<Map<String, dynamic>> getAllEventsByDays(
      BuildContext context, DateTime startDate, DateTime endDate) async {
    const String path = '/event/getBetweenDays';

    String formatDate(DateTime date) {
      return "${date.toIso8601String()}Z"; // Ajout du "Z" à la fin
    }

    final String uri =
        '${EnvironnementVariable.apiUrl}$path?from=${formatDate(startDate)}&to=${formatDate(endDate)}';

    final String? token = await secureStorageManagement.readData('token_jwt');

    try {
      final response = await http.get(
        Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> eventsList = json.decode(response.body);
        if (eventsList.isNotEmpty) {
          // Traitez les événements ici
          return eventsList;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Aucun événement trouvé')),
          );
          return {};
        }
      } else {
        _logger.severe('Erreur du serveur: ${response.statusCode}');
        final errorMessage = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $errorMessage')),
        );
        return {};
      }
    } catch (error, stackTrace) {
      _logger.severe('Erreur lors de la connexion: $error , $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Erreur lors de la connexion : ${error.toString()}')),
      );
      return {};
    }
  }
}
