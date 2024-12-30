import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:mealci/components/snap_layout.dart';

class OcrLogic extends StatefulWidget {
  const OcrLogic({super.key});

  @override
  State<OcrLogic> createState() => _OcrLogicState();
}

class _OcrLogicState extends State<OcrLogic> {
  String? _capturedImagePath;
  final TextRecognizer _textRecognizer = TextRecognizer();
  String _recognizedText = '';

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
            recognizedText: _recognizedText,
          ),
        ),
      );
    }
  }

  Future<void> _processImage(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final recognizedText = await _textRecognizer.processImage(inputImage);
      setState(() => _recognizedText = recognizedText.text);
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
  final String recognizedText;

  const ResultScreen({
    Key? key,
    required this.imagePath,
    required this.recognizedText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteredText = _filterAndFormatText(recognizedText);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.file(File(imagePath)),
            const SizedBox(height: 16.0),
            ...filteredText.map(
              (line) => Text(
                line.join(' '),
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<List<String>> _filterAndFormatText(String text) {
    // Divise le texte en lignes
    final lines = text.split('\n');

    return lines
        .map((line) {
          // Sépare les composants en utilisant une expression régulière
          var components =
              line.split(RegExp(r'\d+(?:G|KG|XMG|X|CL|x|\s?pièces?)'));

          // Filtre les composants indésirables et nettoie les chaînes
          components = components
              .where((component) =>
                  component.trim().isNotEmpty) // Supprime les chaînes vides
              .where((component) =>
                  component.length >
                  3) // Garde les chaînes de plus de 3 caractères
              .where((component) => !RegExp(r'^\d+([.,]\d*)')
                  .hasMatch(component)) // Exclut les nombres
              .map((component) =>
                  component.trim()) // Supprime les espaces inutiles
              .toList();

          return components;
        })
        .where((line) => line.isNotEmpty) // Supprime les lignes vides
        .where((line) => !line.any((word) =>
            RegExp(r'\btotal\b', caseSensitive: false)
                .hasMatch(word) || // Exclut les lignes contenant "total"
            RegExp(r'\d+.*articles', caseSensitive: false)
                .hasMatch(word))) // Exclut les lignes avec "articles"
        .toList();
  }
}
