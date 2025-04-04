import 'package:flutter/material.dart';
import 'package:mealci/components/openfoodfact_details_product.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class QrCameraPreviewScreen extends StatefulWidget {
  const QrCameraPreviewScreen({super.key});

  @override
  State<QrCameraPreviewScreen> createState() => _QrCameraPreviewScreenState();
}

class _QrCameraPreviewScreenState extends State<QrCameraPreviewScreen> {
  final MobileScannerController cameraController = MobileScannerController();
  String barcode = '';
  bool isScanning = false;
  bool isFlashOn = false;

  // Quand un code est détecté
  void onBarcodeDetected(BarcodeCapture capture) async {
    final code = capture.barcodes.first.rawValue;
    if (!isScanning && code != null) {
      setState(() {
        isScanning = true;
        barcode = code;
      });

      cameraController.stop(); // stop la caméra
      await fetchProductDetails(code);
    }
  }

  Future<void> fetchProductDetails(String barcode) async {
    final url = 'https://world.openfoodfacts.org/api/v0/product/$barcode.json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              barcode: barcode,
              controller: null, // QRViewController n'est plus utilisé
            ),
          ),
        ).then((_) {
          setState(() {
            isScanning = false;
          });
          cameraController.start(); // redémarrer la caméra
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Erreur'),
              content: const Text('Produit non trouvé'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      isScanning = false;
                    });
                    cameraController.start();
                  },
                  child: const Text('Fermer'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void toggleFlash() {
    setState(() {
      isFlashOn = !isFlashOn;
    });
    cameraController.toggleTorch();
  }

  void close() {
    Navigator.pop(context, barcode);
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: onBarcodeDetected,
          ),
          Positioned(
            child: Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
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
