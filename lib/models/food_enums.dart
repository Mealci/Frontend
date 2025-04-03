enum StateFood { present, eat, discard }

enum MeasureFood { piece, liter, kilogram }

enum CategoryFood {
  fruits,
  vegetables,
  cereals,
  proteins,
  dairy_Products,
  starchy,
  oils,
  sugar_Products,
  beverage,
  spices,
  prepared_Meals,
}

CategoryFood mapCategory(String category) {
  switch (category.toLowerCase()) {
    case "fruits":
      return CategoryFood.fruits;
    case "vegetables":
      return CategoryFood.vegetables;
    case "cereals":
      return CategoryFood.cereals;
    case "proteins":
      return CategoryFood.proteins;
    case "dairy products":
      return CategoryFood.dairy_Products;
    case "starchy":
      return CategoryFood.starchy;
    case "oils":
      return CategoryFood.oils;
    case "sugar products":
      return CategoryFood.sugar_Products;
    case "beverage":
      return CategoryFood.beverage;
    case "spices":
      return CategoryFood.spices;
    case "prepared meals":
      return CategoryFood.prepared_Meals;
    default:
      return CategoryFood.prepared_Meals;
  }
}
