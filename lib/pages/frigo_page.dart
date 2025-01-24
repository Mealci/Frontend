import 'package:flutter/material.dart';
import 'package:mealci/components/button_profile.dart';
import 'package:mealci/components/button_text_icon.dart';
import 'package:mealci/components/fridge_raiting_chart.dart';
import 'package:mealci/components/feed_fridge_button.dart';
import 'package:mealci/utils/styles/style.dart';

class FrigoPage extends StatefulWidget {
  const FrigoPage({super.key});

  @override
  State<FrigoPage> createState() => _FrigoPageState();
}

class _FrigoPageState extends State<FrigoPage> {
  final double spacing = 14.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Bouton profile en haut à droite
          Positioned(
            top: 50,
            right: 30,
            child: ButtonProfile(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Profile'),
                      content: const Text('Profile page'),
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
          ),

          // Contenu principal : aligné en haut
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Titre avec opacité dynamique
                  const Text(
                    'Mon Frigo',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Voltaire',
                    ),
                  ),

                  SizedBox(
                      height: spacing *
                          2), // Espacement entre le titre et le graphique

                  // Graphique
                  const FridgeRaitingChart(
                    progressA: 0.4,
                    progressB: 0.7,
                    progressC: 0.5,
                  ),
                  SizedBox(
                      height:
                          spacing), // Espacement entre le graphique et le bouton

                  // Bouton "Nourrissez le frigo"
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

                  SizedBox(
                      height: spacing *
                          2), // Espacement entre le bouton et les éléments

                  // Partie scrollable : uniquement les boutons
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ButtonTextIcon(
                                  text: "Boisson",
                                  svgPath: CustomMealciAsset.drinkIcon,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text('Boisson'),
                                          content: Text('Boisson page'),
                                          actions: [],
                                        );
                                      },
                                    );
                                  },
                                ),
                                ButtonTextIcon(
                                  text: "Produits laitiers",
                                  svgPath: CustomMealciAsset.milkIcon,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text('Produits laitiers'),
                                          content:
                                              Text('Produits laitiers page'),
                                          actions: [],
                                        );
                                      },
                                    );
                                  },
                                ),
                                ButtonTextIcon(
                                  text: "Fruits",
                                  svgPath: CustomMealciAsset.fruitIcon,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text('Fruit'),
                                          content: Text('Fruit page'),
                                          actions: [],
                                        );
                                      },
                                    );
                                  },
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
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text('Légumineuses'),
                                          content: Text('Légumineuses page'),
                                          actions: [],
                                        );
                                      },
                                    );
                                  },
                                ),
                                ButtonTextIcon(
                                  text: "Légumes",
                                  svgPath: CustomMealciAsset.legumeIcon,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text('Légumes'),
                                          content: Text('Légumes page'),
                                          actions: [],
                                        );
                                      },
                                    );
                                  },
                                ),
                                ButtonTextIcon(
                                  text: "Féculents",
                                  svgPath: CustomMealciAsset.feculentIcon,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text('Féculents'),
                                          content: Text('Féculents page'),
                                          actions: [],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: spacing),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ButtonTextIcon(
                                  text: "Sucre",
                                  svgPath: CustomMealciAsset.sugarIcon,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text('Sucre'),
                                          content: Text('Sucre page'),
                                          actions: [],
                                        );
                                      },
                                    );
                                  },
                                ),
                                ButtonTextIcon(
                                  text: "Épices",
                                  svgPath: CustomMealciAsset.spicyIcon,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text('Épices'),
                                          content: Text('Épices page'),
                                          actions: [],
                                        );
                                      },
                                    );
                                  },
                                ),
                                ButtonTextIcon(
                                  text: "Huile",
                                  svgPath: CustomMealciAsset.oilIcon,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text('Huile'),
                                          content: Text('Huile page'),
                                          actions: [],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: spacing),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ButtonTextIcon(
                                  text: "Junk Food",
                                  svgPath: CustomMealciAsset.junkFoodIcon,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text('Junk Food'),
                                          content: Text('Junk Food page'),
                                          actions: [],
                                        );
                                      },
                                    );
                                  },
                                ),
                                ButtonTextIcon(
                                  text: "Aliment diététique",
                                  svgPath: CustomMealciAsset.dietIcon,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text('Aliment diététique'),
                                          content:
                                              Text('Aliment diététique page'),
                                          actions: [],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
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
