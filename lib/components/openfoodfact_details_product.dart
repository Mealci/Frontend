import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealci/models/food_enums.dart';
import 'package:mealci/models/food_model.dart';
import 'package:mealci/services/openfoodfact_service.dart';
import 'package:mealci/utils/styles/style.dart';
import 'package:mealci/services/frigo_service.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String barcode;
  final dynamic controller;

  const ProductDetailsScreen({
    super.key,
    required this.barcode,
    required this.controller,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final OpenFoodFactsService _foodFactsService = OpenFoodFactsService();
  final FrigoService _frigoService = FrigoService();
  Map<String, dynamic>? product;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  Future<void> _fetchProductDetails() async {
    final data = await _foodFactsService.getProductFromBarCode(widget.barcode);
    setState(() {
      product = data;
      isLoading = false;
    });

    if (product != null) {
      await _createFood();
    }
  }

  CategoryFood getCategory(String foodName) {
    foodName = foodName
        .toLowerCase(); // Convertir en minuscule pour éviter les erreurs de casse
    for (var entry in categoryKeywords.entries) {
      if (entry.value.any((keyword) => foodName.contains(keyword))) {
        return entry.key;
      }
    }
    return CategoryFood.prepared_Meals;
  }

  MeasureFood _getMeasureFood(String measure) {
    switch (measure) {
      case 'g':
        return MeasureFood.kilogram;
      case 'ml':
        return MeasureFood.liter;
      case 'cl':
        return MeasureFood.liter;
      case 'dl':
        return MeasureFood.liter;
      case 'l':
        return MeasureFood.liter;
      case 'kg':
        return MeasureFood.kilogram;
      case 'piece':
        return MeasureFood.piece;
      case 'slices':
        return MeasureFood.piece;
      case 'units':
        return MeasureFood.piece;
      case 'pieces':
        return MeasureFood.piece;
      case 'portion':
        return MeasureFood.piece;
      default:
        return MeasureFood.piece;
    }
  }

  Future<Food> _createFood() async {
    final food = Food(
        name: product?['product_name'] ?? '',
        quantity: double.parse(product?['product_quantity']?.toString() ?? '0'),
        measure: _getMeasureFood(
            product?['product_quantity_unit']?.toString() ?? 'piece'),
        brand: product?['brands'] ?? '',
        state: StateFood.present,
        category: getCategory(product?['_keywords']?.toString() ??
            CategoryFood.prepared_Meals
                .toString()
                .toUpperCase()
                .split('.')
                .last));

    await _frigoService.createFoodFromBarCode(context, food, food.category);

    return food;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          const Center(
            child: Text(
              'Détails du produit',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : product == null
                    ? const Center(
                        child: Text('Produit non trouvé',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)))
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (product!['image_url'] != null)
                              Hero(
                                tag: product!['image_url'],
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.network(
                                    product!['image_url'],
                                    height: 250,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                _buildInfoCard(
                                    'Nutri-Score',
                                    _getIconPath(product!['nutriscore_grade']
                                            ?.toString() ??
                                        '')),
                                const SizedBox(width: 10),
                                _buildInfoCard(
                                    'Nova Group',
                                    _getIconPath(
                                        product!['nova_group']?.toString() ??
                                            '')),
                              ],
                            ),
                            const SizedBox(height: 20),
                            _buildSectionTitle('Ingrédients'),
                            Text(
                              product!['ingredients_text'] ?? 'N/A',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton('Cancel', () {
                  widget.controller.resumeCamera();
                  Navigator.pop(context);
                }),
                _buildButton('Add to My Fridge', () {
                  widget.controller.resumeCamera();
                  _createFood().then((food) {
                    Navigator.pop(context);
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String label, String iconPath) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SvgPicture.asset(iconPath, width: 50, height: 50),
              const SizedBox(height: 8),
              Text(label,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Style.styles[AppStyle.primaryColor],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  String _getIconPath(String value) {
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
      case '1':
        return CustomMealciAsset.novaGroup1;
      case '2':
        return CustomMealciAsset.novaGroup2;
      case '3':
        return CustomMealciAsset.novaGroup3;
      case '4':
        return CustomMealciAsset.novaGroup4;
      default:
        return CustomMealciAsset.nutriScoreA;
    }
  }
}
