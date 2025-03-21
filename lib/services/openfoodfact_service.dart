import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mealci/utils/logger/logger.dart';

class OpenFoodFactsService {
  static const String _baseUrl =
      "https://world.openfoodfacts.org/api/v0/product";

  static final MealciLogger _logger = MealciLogger('OpenFoodFactsService');

  Future<Map<String, dynamic>?> getProductFromBarCode(String barcode) async {
    final url = Uri.parse('$_baseUrl/$barcode.json');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["status"] == 1) {
          return data["product"];
        } else {
          _logger.severe("Erreur de chargement: ${data["status_verbose"]}");
        }
      } else {
        _logger.severe("Erreur de chargement: ${response.statusCode}");
      }
    } catch (e) {
      _logger.severe("Erreur de chargement: $e");
    }
    return null;
  }
}
