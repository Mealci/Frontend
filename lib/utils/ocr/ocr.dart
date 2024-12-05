import 'package:flutter/material.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';

class OcrService extends StatelessWidget {
  const OcrService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScalableOCR(
          getScannedText: (text) {
            print(text);
          },
        ),  
      ),
    );
  }
}

