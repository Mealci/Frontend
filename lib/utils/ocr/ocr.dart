import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mealci/components/snap_layout.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ocrLogic extends StatefulWidget {
  @override
  _ocrLogicState createState() => _ocrLogicState();
}

class _ocrLogicState extends State<ocrLogic> {
  String? capturedImagePath;
  final TextRecognizer _textRecognizer = TextRecognizer();
  String _recognizedText = '';

  @override
  void initState() {
    super.initState();

    // Ajoutez un callback post-frame pour ouvrir la caméra en toute sécurité
    WidgetsBinding.instance.addPostFrameCallback((_) {
      openCamera();
    });
  }

  void openCamera() async {
    // Naviguer vers CameraPreviewScreen
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraPreviewScreen()),
    );

    // Si une image est capturée, la stocker et afficher la page avec texte reconnu
    if (result != null && result is String) {
      setState(() {
        capturedImagePath = result;
      });

      // Processus de reconnaissance de texte et de filtrage
      File imageFile = File(capturedImagePath!);
      await _processImage(imageFile);

      // Passe le texte reconnu et le chemin de l'image à l'écran suivant
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WhiteScreen(
            imagePath: capturedImagePath!,
            recognizedText: _recognizedText, // Passe le texte reconnu
          ),
        ),
      );
    }
  }

  Future<void> _processImage(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);

    try {
      final recognizedText = await _textRecognizer.processImage(inputImage);
      setState(() {
        _recognizedText = recognizedText.text;
      });
    } catch (e) {
      print('Error recognizing text: $e');
    }
  }

  List<List<String>> _splitTextAndFilter(String text) {
    // Split the input string by newlines
    List<String> elements = text.split('\n');

    // List to store the final result
    List<List<String>> result = [];

    // Process each element and break it into separate components
    for (int i = 0; i < elements.length; i++) {
      // Split the element by spaces
      List<String> components =
          elements[i].split(RegExp(r'\d+(?:G|KG|XMG|X|CL|x|\s?pièces?)'));

      // Filter out empty strings
      components = components.where((component) => component != ' ').toList();
      components = components
          .where((component) => !RegExp(r'^\d+([.,]\d*)?$').hasMatch(component))
          .toList();
      components =
          components.where((component) => component.length > 3).toList();
      components =
          components.where((component) => component.isNotEmpty).toList();
      components = components.map((component) => component.trim()).toList();

      // Add the components to the result list
      result.add(components);
    }
    // Remove empty lists
    result = result.where((element) => element.isNotEmpty).toList();

    // Remove elements like "Total 11 articles"
    result = result
        .where((element) => !element.any((component) =>
            RegExp(r'\btotal\b', caseSensitive: false).hasMatch(component) ||
            RegExp(r'\d+.*articles', caseSensitive: false).hasMatch(component)))
        .toList();

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircularProgressIndicator(
            color: Colors.white), // Chargeur temporaire
      ),
    );
  }
}

class WhiteScreen extends StatelessWidget {
  final String imagePath;
  final String recognizedText;

  const WhiteScreen(
      {super.key, required this.imagePath, required this.recognizedText});

  @override
  Widget build(BuildContext context) {
    // Filtrer et transformer le texte reconnu
    List<List<String>> filteredText = _splitTextAndFilter(recognizedText);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:
            const Text("Photo Capturée", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.file(File(imagePath)), // Affiche l'image capturée
            const SizedBox(height: 16.0),
            ...filteredText.map((line) {
              return Text(
                line.join(' '), // Affiche chaque ligne filtrée
                style: const TextStyle(fontSize: 14),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  List<List<String>> _splitTextAndFilter(String text) {
    List<String> elements = text.split('\n');
    List<List<String>> result = [];

    for (int i = 0; i < elements.length; i++) {
      List<String> components =
          elements[i].split(RegExp(r'\d+(?:G|KG|XMG|X|CL|x|\s?pièces?)'));
      components = components.where((component) => component != ' ').toList();
      components = components
          .where((component) => !RegExp(r'^\d+([.,]\d*)?$').hasMatch(component))
          .toList();
      components =
          components.where((component) => component.length > 3).toList();
      components =
          components.where((component) => component.isNotEmpty).toList();
      components = components.map((component) => component.trim()).toList();
      result.add(components);
    }

    result = result.where((element) => element.isNotEmpty).toList();

    result = result
        .where((element) => !element.any((component) =>
            RegExp(r'\btotal\b', caseSensitive: false).hasMatch(component) ||
            RegExp(r'\d+.*articles', caseSensitive: false).hasMatch(component)))
        .toList();

    return result;
  }
}
