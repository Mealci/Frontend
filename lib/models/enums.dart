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

Map<CategoryFood, List<String>> categoryKeywords = {
  CategoryFood.fruits: ["pomme", "banane", "orange", "raisin", "ananas"],
  CategoryFood.vegetables: ["carotte", "courgette", "poivron", "salade"],
  CategoryFood.cereals: ["riz", "blé", "avoine", "céréale", "quinoa"],
  CategoryFood.proteins: ["poulet", "bœuf", "poisson", "œuf", "tofu"],
  CategoryFood.dairy_Products: ["lait", "fromage", "yaourt", "beurre"],
  CategoryFood.starchy: ["pomme de terre", "pâtes", "pain", "maïs"],
  CategoryFood.oils: ["huile", "olive", "colza", "tournesol"],
  CategoryFood.sugar_Products: ["bonbon", "chocolat", "sucre", "confiserie"],
  CategoryFood.beverage: ["eau", "jus", "soda", "café", "thé"],
  CategoryFood.spices: ["sel", "poivre", "curry", "paprika"],
  CategoryFood.prepared_Meals: ["pizza", "lasagne", "soupe", "plat préparé"],
};
