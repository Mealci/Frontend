import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  final String apiUrl =
      "https://api-inference.huggingface.co/models/facebook/bart-large-mnli";
  final String apiKey =
      "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"; // Remplace par ton token Hugging Face

  Future<String> classifyFood(List<String> tags) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "inputs": "Ce produit contient : ${tags.join(", ")}",
          "parameters": {
            "candidate_labels": [
              "fruits",
              "vegetables",
              "cereals",
              "proteins",
              "dairy products",
              "starchy",
              "oils",
              "sugar products",
              "beverage",
              "prepared meals"
            ]
          }
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data["labels"][0]; // La meilleure catégorie trouvée
      } else {
        print("Erreur API : ${response.body}");
        return "prepared_meals"; // Catégorie par défaut en cas d'erreur
      }
    } catch (e) {
      print("Erreur de connexion : $e");
      return "prepared_meals";
    }
  }
}
