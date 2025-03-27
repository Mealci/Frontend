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
  late List<CreateFood> items;

  @override
  void initState() {
    super.initState();
    items = List.from(widget.items);
  }

  void refreshFoodList() async {
    try {
      CategoryFood categoryEnum = CategoryFood.values.firstWhere(
          (e) => e.toString().toUpperCase().split('.').last == widget.category);

      List<CreateFood> updatedItems =
          await FrigoService().fetchFoodByCategory(context, categoryEnum);

      setState(() {
        items = updatedItems;
      });
    } catch (e) {
      debugPrint("Erreur lors de la conversion de la catégorie : $e");
    }
  }

  void deleteFoodById(int id) async {
    FrigoService().deleteFoodById(context, id);
    setState(() {
      items.removeWhere((food) => food.id == id);
    });
  }

  Future<void> patchFoodQuantityById(
      BuildContext context, int id, double quantity) async {
    await FrigoService().patchFoodQuantityById(context, id, quantity);
    refreshFoodList();
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
                        fontFamily: 'Voltaire',
                      ),
                    ),
                    Spacer(flex: 2),
                  ],
                ),
                SizedBox(height: 20),
                FeedFridgeButton(
                  text: "Feed Fridge",
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.greenAccent.shade700,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "A",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "80/100",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Bon",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            title: Text(
                              '${items[index].name} - ${items[index].quantity} ${items[index].measure.toString().split('.').last}',
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
                                    patchFoodQuantityById(
                                        context,
                                        items[index].id,
                                        items[index].quantity + 1);
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (items[index].quantity > 1 &&
                                            items[index].measure ==
                                                MeasureFood.liter ||
                                        items[index].measure ==
                                            MeasureFood.piece) {
                                      patchFoodQuantityById(
                                          context,
                                          items[index].id,
                                          items[index].quantity - 1);
                                    } else {
                                      deleteFoodById(items[index].id);
                                    }
                                  },
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.black,
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
