import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mealci/models/food_enums.dart';
import 'package:mealci/models/food_model.dart';
import 'package:mealci/utils/env/environnementvariable.dart';
import 'package:mealci/utils/logger/logger.dart';
import 'package:mealci/utils/secure_storage/secure_storage_management.dart';

class FrigoService {
  static final MealciLogger _logger = MealciLogger('FrigoPage');

  final SecureStorageManagement _storage = SecureStorageManagement();

  Future<List<CreateFood>> fetchFoodByCategory(
      BuildContext context, CategoryFood category) async {
    String? token = await _storage.readData('token_jwt');

    if (token == null) {
      _logger.info('Utilisateur non authentifié. Veuillez vous connecter.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Utilisateur non authentifié. Veuillez vous connecter.')),
      );
      Navigator.pushNamed(context, '/loginThirdPage');
    }

    final String foodByCategoryPath =
        '/food/getFoodsByCategory?category=${category.toString().toUpperCase().split('.').last}';
    final Uri foodByCategoryUri =
        Uri.parse('${EnvironnementVariable.apiUrl}$foodByCategoryPath');

    final response =
        await http.get(foodByCategoryUri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 401) {
      _logger.info('Session expirée. Veuillez vous reconnecter.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Session expirée. Veuillez vous reconnecter.')),
      );
      Navigator.pushNamed(context, '/loginThirdPage');
    }

    if (response.statusCode == 200) {
      return parseFoodByCategory(utf8.decode(response.bodyBytes));
    } else {
      throw Exception(
          'Échec du chargement des données des catégories d\'aliments');
    }
  }

  Future<void> createFoodFromBarCode(
      BuildContext context, Food food, CategoryFood category) async {
    String? token = await _storage.readData('token_jwt');

    if (token == null) {
      _logger.info('Utilisateur non authentifié. Veuillez vous connecter.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Utilisateur non authentifié. Veuillez vous connecter.')),
      );
      Navigator.pushNamed(context, '/loginThirdPage');
    }

    final String createFoodPath = '/food/create';
    final Uri createFoodUri =
        Uri.parse('${EnvironnementVariable.apiUrl}$createFoodPath');
    final response = await http.post(
      createFoodUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'name': food.name,
        'quantity': food.quantity,
        'measure': food.measure.toString().toUpperCase().split('.').last,
        'brand': food.brand,
        'state': food.state.toString().toUpperCase().split('.').last,
        'category': category.toString().toUpperCase().split('.').last,
      }),
    );
    if (response.statusCode == 401) {
      _logger.info('Session expirée. Veuillez vous reconnecter.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Session expirée. Veuillez vous reconnecter.')),
      );
      Navigator.pushNamed(context, '/loginThirdPage');
    }

    if (response.statusCode == 200) {
      _logger.info('Aliment créé avec succès');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aliment créé avec succès')),
      );
    } else {
      _logger.severe(
          'Échec de la création de l\'aliment : ${response.statusCode}');
      throw Exception('Échec de la création de l\'aliment');
    }
  }

  void deleteFoodById(BuildContext context, int id) async {
    String? token = await _storage.readData('token_jwt');

    if (token == null) {
      _logger.info('Utilisateur non authentifié. Veuillez vous connecter.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Utilisateur non authentifié. Veuillez vous connecter.')),
      );
      Navigator.pushNamed(context, '/loginThirdPage');
    }

    final String deleteFoodPath = '/food/deleteFood?id=$id';
    final Uri deleteFoodUri =
        Uri.parse('${EnvironnementVariable.apiUrl}$deleteFoodPath');

    final response = await http.delete(deleteFoodUri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 401) {
      _logger.info('Session expirée. Veuillez vous reconnecter.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Session expirée. Veuillez vous reconnecter.')),
      );
      Navigator.pushNamed(context, '/loginThirdPage');
    }

    if (response.statusCode == 200) {
      _logger.info('Aliment supprimé avec succès');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aliment supprimé avec succès')),
      );
    } else {
      throw Exception('Échec de la suppression de l\'aliment');
    }
  }

  Future patchFoodQuantityById(
      BuildContext context, int id, double quantity) async {
    String? token = await _storage.readData('token_jwt');

    if (token == null) {
      _logger.info('Utilisateur non authentifié. Veuillez vous connecter.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Utilisateur non authentifié. Veuillez vous connecter.')),
      );
      Navigator.pushNamed(context, '/loginThirdPage');
    }

    final String patchFoodPath = '/food/quantity/$id/$quantity';
    final Uri patchFoodUri =
        Uri.parse('${EnvironnementVariable.apiUrl}$patchFoodPath');

    final response = await http.patch(patchFoodUri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'id': id, 'quantity': quantity}));

    if (response.statusCode == 401) {
      _logger.info('Session expirée. Veuillez vous reconnecter.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Session expirée. Veuillez vous reconnecter.')),
      );
      Navigator.pushNamed(context, '/loginThirdPage');
    }

    if (response.statusCode == 200) {
      _logger.info('Quantité de l\'aliment modifiée avec succès');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Quantité de l\'aliment modifiée avec succès')),
      );
    } else {
      throw Exception('Échec de la modification de la quantité de l\'aliment');
    }
  }
}

List<CreateFood> parseFoodByCategory(String responseBody) {
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed.map<CreateFood>((json) => CreateFood.fromJson(json)).toList();
}
