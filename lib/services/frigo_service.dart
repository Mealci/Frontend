import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mealci/models/enums.dart';
import 'package:mealci/models/food_model.dart';
import 'package:mealci/utils/env/environnementvariable.dart';

class FrigoService {
  Future<List<Food>> fetchFoodByCategory(
      BuildContext context, CategoryFood category) async {
    final String foodByCategoryPath =
        '/food/getFoodsByCategory?category=${category.toString().split('.').last}';
    final Uri foodByCategoryUri =
        Uri.parse('${EnvironnementVariable.apiUrl}$foodByCategoryPath');

    final response =
        await http.get(foodByCategoryUri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      return parseFoodByCategory(response.body);
    } else {
      throw Exception(
          'Échec du chargement des données des catégories d\'aliments');
    }
  }
}

List<Food> parseFoodByCategory(String responseBody) {
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed.map<Food>((json) => Food.fromJson(json)).toList();
}
