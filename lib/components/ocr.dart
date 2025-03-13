import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:mealci/components/camera_preview_screen.dart';

class OcrLogic extends StatefulWidget {
  const OcrLogic({super.key});

  @override
  State<OcrLogic> createState() => _OcrLogicState();
}

class _OcrLogicState extends State<OcrLogic> {
  String? _capturedImagePath;
  final TextRecognizer _textRecognizer = TextRecognizer();
  Map<String, dynamic> _recognizedJson = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _openCamera());
  }

  Future<void> _openCamera() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraPreviewScreen()),
    );

    if (result is String) {
      setState(() => _capturedImagePath = result);
      final imageFile = File(_capturedImagePath!);
      await _processImage(imageFile);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            imagePath: _capturedImagePath!,
            recognizedJson: _recognizedJson,
          ),
        ),
      );
    }
  }

  Future<void> _processImage(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      List<Map<String, dynamic>> blocks = recognizedText.blocks.map((block) {
        return {
          "text": block.text,
          "boundingBox": block.boundingBox.toString(),
          "lines": block.lines.map((line) => line.text).toList(),
        };
      }).toList();

      setState(() {
        _recognizedJson = {"text": recognizedText.text, "blocks": blocks};
      });
    } catch (e) {
      debugPrint('Error recognizing text: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final String imagePath;
  final Map<String, dynamic> recognizedJson;

  const ResultScreen({
    super.key,
    required this.imagePath,
    required this.recognizedJson,
  });

  @override
  Widget build(BuildContext context) {
    print(jsonEncode(recognizedJson));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.file(File(imagePath)),
            const SizedBox(height: 16.0),
            Text(
              jsonEncode(recognizedJson),
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
