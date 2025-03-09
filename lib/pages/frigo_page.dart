import 'package:flutter/material.dart';
import 'package:mealci/components/button_text_icon.dart';
import 'package:mealci/components/feed_fridge_button.dart';
import 'package:mealci/components/fridge_rating_chart.dart';
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
  bool isFridgeSane = true;

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
      List<Food> foodItems = await FrigoService().fetchFoodByCategory(category);

      frigoCategories[category.toString().split('.').last] = foodItems;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
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

                  // Graphique
                  const FridgeRatingChart(
                    progressA: 0.4,
                    progressB: 0.7,
                    progressC: 0.5,
                  ),

                  FeedFridgeButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Feed Fridge'),
                            content: const Text('Feed Fridge page'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: spacing),
                          for (int i = 0;
                              i < CategoryFood.values.length;
                              i += 3)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ButtonTextIcon(
                                  text: CategoryFood.values[i]
                                      .toString()
                                      .split('.')
                                      .last,
                                  svgPath: getIconForCategory(
                                      CategoryFood.values[i]),
                                  onPressed: () {
                                    setState(() {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GenericLayout(
                                            title:
                                                "Détails des ${CategoryFood.values[i].toString().split('.').last}",
                                            child: FrigoDetailPage(
                                              category: CategoryFood.values[i]
                                                  .toString()
                                                  .split('.')
                                                  .last,
                                              items: frigoCategories[
                                                      CategoryFood.values[i]
                                                          .toString()
                                                          .split('.')
                                                          .last] ??
                                                  [],
                                              image: getIconForCategory(
                                                  CategoryFood.values[i]),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                ),
                                if (i + 1 < CategoryFood.values.length)
                                  ButtonTextIcon(
                                    text: CategoryFood.values[i + 1]
                                        .toString()
                                        .split('.')
                                        .last,
                                    svgPath: getIconForCategory(
                                        CategoryFood.values[i + 1]),
                                    onPressed: () {
                                      setState(() {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => GenericLayout(
                                              title:
                                                  "Détails des ${CategoryFood.values[i + 1].toString().split('.').last}",
                                              child: FrigoDetailPage(
                                                category: CategoryFood
                                                    .values[i + 1]
                                                    .toString()
                                                    .split('.')
                                                    .last,
                                                items: frigoCategories[
                                                        CategoryFood
                                                            .values[i + 1]
                                                            .toString()
                                                            .split('.')
                                                            .last] ??
                                                    [],
                                                image: getIconForCategory(
                                                    CategoryFood.values[i + 1]),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                  ),
                                if (i + 2 < CategoryFood.values.length)
                                  ButtonTextIcon(
                                    text: CategoryFood.values[i + 2]
                                        .toString()
                                        .split('.')
                                        .last,
                                    svgPath: getIconForCategory(
                                        CategoryFood.values[i + 2]),
                                    onPressed: () {
                                      setState(() {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => GenericLayout(
                                              title:
                                                  "Détails des ${CategoryFood.values[i + 2].toString().split('.').last}",
                                              child: FrigoDetailPage(
                                                category: CategoryFood
                                                    .values[i + 2]
                                                    .toString()
                                                    .split('.')
                                                    .last,
                                                items: frigoCategories[
                                                        CategoryFood
                                                            .values[i + 2]
                                                            .toString()
                                                            .split('.')
                                                            .last] ??
                                                    [],
                                                image: getIconForCategory(
                                                    CategoryFood.values[i + 2]),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                  ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getIconForCategory(CategoryFood category) {
    switch (category) {
      case CategoryFood.FRUITS:
        return CustomMealciAsset.fruitIcon;
      case CategoryFood.VEGETABLES:
        return CustomMealciAsset.vegetableIcon;
      case CategoryFood.CEREALS:
        return CustomMealciAsset.cerealIcon;
      case CategoryFood.PROTEINS:
        return CustomMealciAsset.meatIcon;
      case CategoryFood.DAIRY_PRODUCTS:
        return CustomMealciAsset.milkIcon;
      case CategoryFood.BEVERAGE:
        return CustomMealciAsset.drinkIcon;
      case CategoryFood.OILS:
        return CustomMealciAsset.oilIcon;
      case CategoryFood.SPICES:
        return CustomMealciAsset.spicyIcon;
      case CategoryFood.SUGAR_PRODUCTS:
        return CustomMealciAsset.sugarIcon;
      case CategoryFood.PREPARED_MEALS:
        return CustomMealciAsset.junkFoodIcon;
      case CategoryFood.STARCHY:
        return CustomMealciAsset.starchIcon;
      default:
        return CustomMealciAsset.fridgeIcon;
    }
  }
}
