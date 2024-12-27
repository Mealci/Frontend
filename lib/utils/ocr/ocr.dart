import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class TextRecognitionScreen extends StatefulWidget {
  const TextRecognitionScreen({super.key});

  @override
  _TextRecognitionScreenState createState() => _TextRecognitionScreenState();
}

class _TextRecognitionScreenState extends State<TextRecognitionScreen> {
  final ImagePicker _picker = ImagePicker();
  final TextRecognizer _textRecognizer = TextRecognizer();
  String _recognizedText = '';

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
      });
      _processImage(File(pickedFile.path));
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

  @override
  void dispose() {
    _textRecognizer.close();
    super.dispose();
  }

List<List<String>> _splitText(String text) {
  // Split the input string by newlines
  List<String> elements = text.split('\n');

  // Filter out empty strings and only keep elements containing numbers with valid units
  elements = elements.where((element) => element.isNotEmpty && 
    element.contains(RegExp(r'\d+(?:G|KG|x|\s?pièces?)'))).toList();

  // List to store the final result
  List<List<String>> result = [];

  // Process each element and break it into separate components
  for (int i = 0; i < elements.length; i++) {
    // Split the element by spaces
    List<String> components = elements[i].split(' ');

    // List to store the final components
    List<String> finalComponents = [];

    // Process each component
    for (int j = 0; j < components.length; j++) {
      components[j] = components[j].contains(
    }

    // Add the final components list to the result list
    result.add(finalComponents);
  }

  return result;
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text Recognition')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickImage,
            child: const Text('Pick Image'),
          ),
          const SizedBox(height: 16),
          Text(
            _recognizedText.isNotEmpty ? _splitText(_recognizedText).toString() : 'No text recognized.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
