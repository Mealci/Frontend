import 'package:flutter/material.dart';
import 'package:mealci/components/button_text_icon.dart';
import 'package:mealci/components/feed_fridge_button.dart';
import 'package:mealci/utils/styles/style.dart';
import 'package:mealci/components/checking_fridge_sanity_card.dart';

class FrigoPage extends StatefulWidget {
  const FrigoPage({super.key});

  @override
  State<FrigoPage> createState() => _FrigoPageState();
}

class _FrigoPageState extends State<FrigoPage> {
  final double spacing = 14.0;
  bool isFridgeSane = true;

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
                  CheckingFridgeSanityCard(isFridgeSane: isFridgeSane),
                  SizedBox(height: spacing),
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
                  SizedBox(height: spacing * 2),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ButtonTextIcon(
                                text: "Fruits",
                                svgPath: CustomMealciAsset.fruitIcon,
                                onPressed: () {},
                              ),
                              ButtonTextIcon(
                                text: "Légumes",
                                svgPath: CustomMealciAsset.legumeIcon,
                                onPressed: () {},
                              ),
                              ButtonTextIcon(
                                text: "Viandes",
                                svgPath: CustomMealciAsset.meatIcon,
                                onPressed: () {},
                              ),
                            ],
                          ),
                          SizedBox(height: spacing),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ButtonTextIcon(
                                text: "Poissons",
                                svgPath: CustomMealciAsset.fishIcon,
                                onPressed: () {},
                              ),
                              ButtonTextIcon(
                                text: "Produits laitiers",
                                svgPath: CustomMealciAsset.milkIcon,
                                onPressed: () {},
                              ),
                              ButtonTextIcon(
                                text: "Céréales",
                                svgPath: CustomMealciAsset.feculentIcon,
                                onPressed: () {},
                              ),
                            ],
                          ),
                          SizedBox(height: spacing),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ButtonTextIcon(
                                text: "Légumineuses",
                                svgPath: CustomMealciAsset.legumineuseIcon,
                                onPressed: () {},
                              ),
                              ButtonTextIcon(
                                text: "Œufs",
                                svgPath: CustomMealciAsset.fishIcon,
                                onPressed: () {},
                              ),
                              ButtonTextIcon(
                                text: "Huiles",
                                svgPath: CustomMealciAsset.oilIcon,
                                onPressed: () {},
                              ),
                            ],
                          ),
                          SizedBox(height: spacing),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ButtonTextIcon(
                                text: "Produits sucrés",
                                svgPath: CustomMealciAsset.sugarIcon,
                                onPressed: () {},
                              ),
                              ButtonTextIcon(
                                text: "Boissons",
                                svgPath: CustomMealciAsset.drinkIcon,
                                onPressed: () {},
                              ),
                              ButtonTextIcon(
                                text: "Condiments",
                                svgPath: CustomMealciAsset.spicyIcon,
                                onPressed: () {},
                              ),
                            ],
                          ),
                          SizedBox(height: spacing),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ButtonTextIcon(
                                text: "Plats préparés",
                                svgPath: CustomMealciAsset.junkFoodIcon,
                                onPressed: () {},
                              ),
                              ButtonTextIcon(
                                text: "Fruits secs",
                                svgPath: CustomMealciAsset.legumineuseIcon,
                                onPressed: () {},
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
}
