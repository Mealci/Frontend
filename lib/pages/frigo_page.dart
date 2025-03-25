import 'package:flutter/material.dart';
import 'package:mealci/components/button_text_icon.dart';
import 'package:mealci/components/feed_fridge_button.dart';
import 'package:mealci/components/fridge_rating_chart.dart';
import 'package:mealci/utils/routes/routes.dart';
import 'package:mealci/components/generic_layout.dart';
import 'package:mealci/models/enums.dart';
import 'package:mealci/models/food_model.dart';
import 'package:mealci/pages/frigo_detail_page.dart';
import 'package:mealci/services/frigo_service.dart';
import 'package:mealci/utils/styles/style.dart';

class FrigoPage extends StatefulWidget {
  const FrigoPage({super.key});

  @override
  State<FrigoPage> createState() => _FrigoPageState();
}

class _FrigoPageState extends State<FrigoPage> {
  final double spacing = 14.0;

  late Map<String, List<Food>> frigoCategories;

  @override
  void initState() {
    super.initState();
    frigoCategories = {};
    getFoodData();
  }

  Future getFoodData() async {
    List<CategoryFood> categories = CategoryFood.values;

    for (var category in categories) {
      List<Food> foodItems =
          await FrigoService().fetchFoodByCategory(context, category);

      frigoCategories[category.toString().toUpperCase().split('.').last] =
          foodItems;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Mon Frigo',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Voltaire',
                ),
              ),
              const SizedBox(height: 20),

              // Graphique
              const FridgeRatingChart(
                progressA: 0.4,
                progressB: 0.7,
                progressC: 0.5,
              ),
              const SizedBox(height: 20),

              FeedFridgeButton(
                text: "Feed Fridge",
                onPressed: () {
                  Navigator.pushNamed(context, Routes.scanBarCode);
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: screenWidth / 3, // Nombre de colonnes
                    crossAxisSpacing: 15, // Espacement horizontal
                    mainAxisSpacing: 15, // Espacement vertical
                    childAspectRatio: 1.3, // Ratio largeur/hauteur des boutons
                  ),
                  itemCount: CategoryFood.values.length,
                  itemBuilder: (context, index) {
                    final category = CategoryFood.values[index];
                    return ButtonTextIcon(
                      text: category.toString().toUpperCase().split('.').last,
                      svgPath: getIconForCategory(category),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GenericLayout(
                              title:
                                  "Détails des ${category.toString().toUpperCase().split('.').last}",
                              child: FrigoDetailPage(
                                category: category
                                    .toString()
                                    .toUpperCase()
                                    .split('.')
                                    .last,
                                items: frigoCategories[category
                                        .toString()
                                        .toUpperCase()
                                        .split('.')
                                        .last] ??
                                    [],
                                image: getIconForCategory(category),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getIconForCategory(CategoryFood category) {
    switch (category) {
      case CategoryFood.fruits:
        return CustomMealciAsset.fruitIcon;
      case CategoryFood.vegetables:
        return CustomMealciAsset.vegetableIcon;
      case CategoryFood.cereals:
        return CustomMealciAsset.cerealIcon;
      case CategoryFood.proteins:
        return CustomMealciAsset.meatIcon;
      case CategoryFood.dairy_Products:
        return CustomMealciAsset.milkIcon;
      case CategoryFood.beverage:
        return CustomMealciAsset.drinkIcon;
      case CategoryFood.oils:
        return CustomMealciAsset.oilIcon;
      case CategoryFood.spices:
        return CustomMealciAsset.spicyIcon;
      case CategoryFood.sugar_Products:
        return CustomMealciAsset.sugarIcon;
      case CategoryFood.prepared_Meals:
        return CustomMealciAsset.junkFoodIcon;
      case CategoryFood.starchy:
        return CustomMealciAsset.starchIcon;
    }
  }
}
