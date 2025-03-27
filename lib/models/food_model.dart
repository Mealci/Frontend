import 'enums.dart';

class Food {
  String name;
  double quantity;
  MeasureFood measure;
  String brand;
  CategoryFood category;
  StateFood state = StateFood.present;

  Food(
      {required this.name,
      required this.quantity,
      required this.measure,
      required this.brand,
      required this.category,
      this.state = StateFood.present});

  String get getName => name;
  double get getQuantity => quantity;
  MeasureFood get getMeasure => measure;
  String get getBrand => brand;
  CategoryFood get getCategory => category;
  StateFood get getState => state;

  set setName(String name) => this.name = name;
  set setQuantity(double quantity) => this.quantity = quantity;
  set setMeasure(MeasureFood measure) => this.measure = measure;
  set setBrand(String brand) => this.brand = brand;
  set setCategory(CategoryFood category) => this.category = category;
  set setState(StateFood state) => this.state = state;

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
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
    );
  }
}
