import 'package:flutter/material.dart';
import 'package:mealci/components/openfoodfact_details_product.dart';
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

  void onScan(QRViewController controller) {
    // Listen for scan data
    controller.scannedDataStream.listen((scanData) async {
      // Check if a barcode is detected
      if (scanData.code != null) {
        // Pause the camera to stop further scanning
        controller.pauseCamera();

        setState(() {
          barcode = scanData.code!;
        });

        // Fetch product details
        await fetchProductDetails(barcode, controller);
      }
    });
  }

  // Méthode pour obtenir les détails du produit depuis Open Food Facts
  Future<void> fetchProductDetails(
      String barcode, QRViewController controller) async {
    final url = 'https://world.openfoodfacts.org/api/v0/product/$barcode.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 1) {
        // Navigate to the product details screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetailsScreen(barcode: barcode, controller: controller),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Erreur'),
              content: const Text('Produit non trouvé'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
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
                  color: Colors.black.withAlpha(128),
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
                  color: Colors.black.withAlpha(50),
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
