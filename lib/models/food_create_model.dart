import 'package:mealci/models/food_enums.dart';
import 'package:mealci/models/food_model.dart';

class CreateFood extends Food {
  int id;

  CreateFood({
    required this.id,
    required super.name,
    required super.quantity,
    required super.measure,
    required super.brand,
    required super.category,
    super.barcode = '',
    super.novaGroupScore = '',
    super.nutriScore = '',
    super.state,
  });

  int get getId => id;
  set setId(int id) => this.id = id;

  factory CreateFood.fromJson(Map<String, dynamic> json) {
    return CreateFood(
      id: json['id'],
      name: json['food']['name'],
      quantity: json['food']['quantity'],
      measure: MeasureFood.values.firstWhere(
        (e) =>
            e.toString().toUpperCase().split('.').last ==
            json['food']['measure'],
        orElse: () => MeasureFood.piece,
      ),
      brand: json['food']['brand'],
      category: CategoryFood.values.firstWhere(
        (e) =>
            e.toString().toUpperCase().split('.').last ==
            json['food']['category'],
        orElse: () => CategoryFood.fruits,
      ),
      state: StateFood.values.firstWhere(
        (e) =>
            e.toString().toUpperCase().split('.').last == json['food']['state'],
        orElse: () => StateFood.present,
      ),
      barcode: json['food']['barcode'],
      novaGroupScore: json['food']['novaGroupScore'],
      nutriScore: json['food']['nutriScore'],
    );
  }
}
