class Food {
  String name = '';
  double quantity = 0;
  String unit = '';
  String brand = '';

  Food(
      {required this.name,
      required this.quantity,
      required this.unit,
      required this.brand});

  String get getName => name;
  double get getQuantity => quantity;
  String get getUnit => unit;
  String get getBrand => brand;

  set setName(String name) => this.name = name;
  set setQuantity(double quantity) => this.quantity = quantity;
  set setUnit(String unit) => this.unit = unit;
  set setBrand(String brand) => this.brand = brand;
}
