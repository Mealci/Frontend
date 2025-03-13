import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QrCameraPreviewScreen extends StatefulWidget {
  const QrCameraPreviewScreen({super.key});

  @override
  State<QrCameraPreviewScreen> createState() => _QrCameraPreviewScreenState();
}

class _QrCameraPreviewScreenState extends State<QrCameraPreviewScreen> {
  final GlobalKey<_QrCameraPreviewScreenState> qrKey = GlobalKey();
  String barcode = '';
  bool isFlashOn = false;

  // Méthode pour gérer le résultat du scan
  void onScan(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        barcode = scanData.code!;
      });

      // Appel API Open Food Facts après avoir scanné le code-barres
      await fetchProductDetails(barcode);
    });
  }

  // Méthode pour obtenir les détails du produit depuis Open Food Facts
  Future<void> fetchProductDetails(String barcode) async {
    final url = 'https://world.openfoodfacts.org/api/v0/product/$barcode.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 1) {
        final product = data['product'];
        final productName = product['product_name'] ?? 'Produit inconnu';
        final productCategory =
            product['categories_tags']?.join(', ') ?? 'Aucune catégorie';
        final productImageUrl = product['image_url'] ?? '';

        // Afficher les détails du produit dans une boîte de dialogue
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(productName),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (productImageUrl.isNotEmpty)
                    Image.network(productImageUrl, height: 100),
                  const SizedBox(height: 10),
                  Text('Catégorie: $productCategory'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/scanBarCodePage'),
                  child: const Text('Fermer'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  // Méthode toggle pour activer/désactiver la lampe torche
  void toggleFlash() {
    setState(() {
      isFlashOn = !isFlashOn;
    });
  }

  // Méthode close pour fermer le scanner
  void close() {
    Navigator.pop(context, barcode);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: onScan,
          ),
          Positioned(
            child: Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green, // Vous pouvez changer la couleur ici
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Bouton flash en haut à droite
          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: toggleFlash,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isFlashOn ? Icons.flash_on : Icons.flash_off,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),

          // Bouton fermer en bas à gauche
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: close,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
