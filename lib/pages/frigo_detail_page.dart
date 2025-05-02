import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealci/components/feed_fridge_button.dart';
import 'package:mealci/models/food_create_model.dart';
import 'package:mealci/models/food_enums.dart';
import 'package:mealci/utils/routes/routes.dart';
import 'package:mealci/utils/styles/style.dart';
import 'package:mealci/services/frigo_service.dart';

class FrigoDetailPage extends StatefulWidget {
  final String category;
  final List<CreateFood> items;
  final String image;

  const FrigoDetailPage({
    super.key,
    required this.category,
    required this.items,
    required this.image,
  });

  @override
  State<FrigoDetailPage> createState() => _FrigoDetailPageState();
}

class _FrigoDetailPageState extends State<FrigoDetailPage> {
  List<CreateFood> items = [];

  @override
  void initState() {
    super.initState();
    refreshFoodList();
  }

  Future refreshFoodList() async {
    try {
      CategoryFood categoryEnum = CategoryFood.values.firstWhere(
          (e) => e.toString().toUpperCase().split('.').last == widget.category);

      List<CreateFood> updatedItems =
          await FrigoService().fetchFoodByCategory(context, categoryEnum);

      updatedItems = updatedItems
          .where((item) =>
              item.state != StateFood.eat && item.state != StateFood.discard)
          .toList();

      setState(() {
        items = updatedItems;
      });
    } catch (e) {
      debugPrint("Erreur lors de la conversion de la catégorie : $e");
    }
  }

  Future changeStateFoodById(int id, StateFood food) async {
    await FrigoService().changeStateFoodById(
      context,
      id,
      food,
    );
    await refreshFoodList();
  }

  Future<void> patchFoodQuantityById(
      BuildContext context, int id, double quantity) async {
    await FrigoService().patchFoodQuantityById(context, id, quantity);
    await refreshFoodList();
  }

  void _confirmDeleteFood(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Le produit a-t-il été jeté ?"),
          actions: [
            TextButton.icon(
              onPressed: () async {
                debugPrint("L'aliment a été jeté.");
                await changeStateFoodById(id, StateFood.discard);
                Navigator.of(context).pop();
              },
              icon: SvgPicture.asset(
                CustomMealciAsset.deleteIcon,
                width: 20,
                height: 20,
              ),
              label: Text("Jeté", style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annuler"),
            ),
          ],
        );
      },
    );
  }

  void _confirmEatFood(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Le produit a-t-il été mangé ?"),
          actions: [
            TextButton.icon(
              onPressed: () async {
                debugPrint("L'aliment a été mangé.");
                await changeStateFoodById(id, StateFood.eat);
                Navigator.of(context).pop();
              },
              icon: SvgPicture.asset(
                CustomMealciAsset.appleEatenIcon,
                width: 20,
                height: 20,
              ),
              label: Text("Mangé", style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annuler"),
            ),
          ],
        );
      },
    );
  }

  String _getNutriScorePath(String? value) {
    switch (value) {
      case 'A':
        return CustomMealciAsset.nutriScoreA;
      case 'B':
        return CustomMealciAsset.nutriScoreB;
      case 'C':
        return CustomMealciAsset.nutriScoreC;
      case 'D':
        return CustomMealciAsset.nutriScoreD;
      case 'E':
        return CustomMealciAsset.nutriScoreE;
      default:
        return '';
    }
  }

  String _getNovaGroupPath(String? value) {
    switch (value) {
      case 'ONE':
        return CustomMealciAsset.novaGroup1;
      case 'TWO':
        return CustomMealciAsset.novaGroup2;
      case 'THREE':
        return CustomMealciAsset.novaGroup3;
      case 'FOUR':
        return CustomMealciAsset.novaGroup4;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.home);
                      },
                    ),
                    Spacer(),
                    Text(
                      widget.category,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Spacer(flex: 2),
                  ],
                ),
                SizedBox(height: 20),
                FeedFridgeButton(
                  text: "Feed Fridge",
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.scanBarCode);
                  },
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Style.styles[AppStyle.thirdColor],
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(10),
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            leading: SvgPicture.asset(
                              width: 40,
                              height: 40,
                              widget.image,
                            ),
                            subtitle: Row(
                              children: [
                                SvgPicture.asset(
                                  _getNutriScorePath(items[index].nutriScore),
                                  width: 30,
                                  height: 30,
                                ),
                                SizedBox(width: 10),
                                SvgPicture.asset(
                                  _getNovaGroupPath(
                                      items[index].novaGroupScore),
                                  width: 30,
                                  height: 30,
                                ),
                              ],
                            ),
                            title: Text(
                              items[index].name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _confirmEatFood(items[index].id);
                                  },
                                  icon: SvgPicture.asset(
                                    CustomMealciAsset.appleEatenIcon,
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _confirmDeleteFood(items[index].id);
                                  },
                                  icon: SvgPicture.asset(
                                    CustomMealciAsset.deleteIcon,
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
