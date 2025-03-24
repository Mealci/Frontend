import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPreviewScreen extends StatefulWidget {
  const CameraPreviewScreen({super.key});

  @override
  State<CameraPreviewScreen> createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool isCameraInitialized = false;
  bool isFlashOn = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    _cameras = await availableCameras();

    if (_cameras != null && _cameras!.isNotEmpty) {
      _cameraController = CameraController(
        _cameras![0], // La première caméra (arrière)
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      if (!mounted) return;

      setState(() {
        isCameraInitialized = true;
      });
    }
  }

  Future<void> toggleFlash() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      isFlashOn = !isFlashOn;
      await _cameraController!
          .setFlashMode(isFlashOn ? FlashMode.always : FlashMode.off);
      setState(() {});
    }
  }

  Future<void> pickFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    Navigator.pop(context, image?.path); // Retourne le chemin
  }

  Future<void> capturePhoto() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        final XFile photo = await _cameraController!.takePicture();
        Navigator.pop(context, photo.path); // Retourne le chemin
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la capture de la photo: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Le flux vidéo de la caméra
          isCameraInitialized && _cameraController != null
              ? SizedBox.expand(
                  child: CameraPreview(_cameraController!),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),

          // Bouton pour fermer la caméra
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
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

          // Bouton pour activer/désactiver le flash
          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: toggleFlash,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(50),
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

          // Bouton pour sélectionner une image dans la galerie
          Positioned(
            bottom: 40,
            left: 40,
            child: GestureDetector(
              onTap: pickFromGallery,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(50),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.photo_library,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),

          // Bouton pour capturer la photo
          Positioned(
            bottom: 100,
            left: 0, // Position de départ (ne sera pas utilisée dans Center)
            right: 0, // Étendre horizontalement pour centrer
            child: GestureDetector(
              onTap: capturePhoto,
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  color: Colors.black.withAlpha(50),
                ),
                child: Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
