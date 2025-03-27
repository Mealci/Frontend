import 'package:flutter/material.dart';
import 'package:mealci/components/qr_camera_preview_screen.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  List<Map<String, dynamic>> _recognizedQrCodes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _openCamera());
  }

  Future<void> _openCamera() async {
    final qrValue = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QrCameraPreviewScreen()),
    );

    if (qrValue != null && qrValue is String) {
      setState(() {
        _recognizedQrCodes = [
          {"value": qrValue, "format": "QR_CODE"}
        ];
      });

      // Aller directement à l'écran de résultats
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            imagePath: "",
            recognizedQrCodes: _recognizedQrCodes,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ElevatedButton(
          onPressed: _openCamera,
          child: const Text("Ouvrir le scanner QR",
              style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final String imagePath;
  final List<Map<String, dynamic>> recognizedQrCodes;

  const ResultScreen({
    super.key,
    required this.imagePath,
    required this.recognizedQrCodes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Text(
              recognizedQrCodes.isNotEmpty
                  ? recognizedQrCodes.map((e) => e.toString()).join("\n")
                  : "Aucun QR code détecté.",
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
