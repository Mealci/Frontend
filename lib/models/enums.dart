enum StateFood { PRESENT, EAT, DISCARD }

enum MeasureFood { PIECE, LITER, KILOGRAM }

enum CategoryFood {
  FRUITS,
  VEGETABLES,
  CEREALS,
  PROTEINS,
  DAIRY_PRODUCTS,
  STARCHY,
  OILS,
  SUGAR_PRODUCTS,
  BEVERAGE,
  SPICES,
  PREPARED_MEALS,
}

Map<CategoryFood, List<String>> categoryKeywords = {
  CategoryFood.FRUITS: ["pomme", "banane", "orange", "raisin", "ananas"],
  CategoryFood.VEGETABLES: ["carotte", "courgette", "poivron", "salade"],
  CategoryFood.CEREALS: ["riz", "blé", "avoine", "céréale", "quinoa"],
  CategoryFood.PROTEINS: ["poulet", "bœuf", "poisson", "œuf", "tofu"],
  CategoryFood.DAIRY_PRODUCTS: ["lait", "fromage", "yaourt", "beurre"],
  CategoryFood.STARCHY: ["pomme de terre", "pâtes", "pain", "maïs"],
  CategoryFood.OILS: ["huile", "olive", "colza", "tournesol"],
  CategoryFood.SUGAR_PRODUCTS: ["bonbon", "chocolat", "sucre", "confiserie"],
  CategoryFood.BEVERAGE: ["eau", "jus", "soda", "café", "thé"],
  CategoryFood.SPICES: ["sel", "poivre", "curry", "paprika"],
  CategoryFood.PREPARED_MEALS: ["pizza", "lasagne", "soupe", "plat préparé"],
};
