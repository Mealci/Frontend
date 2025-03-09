import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mealci/models/enums.dart';
import 'package:mealci/models/food_model.dart';
import 'package:mealci/utils/env/environnementvariable.dart';

class FrigoService {
  Future<List<Food>> fetchFoodByCategory(CategoryFood category) async {
    const String foodByCategoryPath = '/food/getFoodsByCategory';
    final Uri foodbyCategoryUri =
        Uri.parse('${EnvironnementVariable.apiUrl}$foodByCategoryPath');
    final response =
        await http.get(foodbyCategoryUri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      return parseFoodByCategory(response.body);
    } else {
      throw Exception('Echec du chargement des données de l\'url');
    }
  }
}

List<Food> parseFoodByCategory(String responseBody) {
  final parsed =
      (jsonDecode(responseBody) as List).cast<Map<String, dynamic>>();

  return parsed.map<Food>((json) => Food.fromJson(json)).toList();
}
