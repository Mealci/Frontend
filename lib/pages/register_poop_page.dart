import 'package:flutter/material.dart';
import 'package:mealci/components/navbar.dart';
import 'package:mealci/components/save_poop_button.dart';
import 'package:mealci/components/snap_layout.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:another_xlider/models/handler.dart';

class RegisterPoopPage extends StatefulWidget {
  const RegisterPoopPage({super.key});

  @override
  State<RegisterPoopPage> createState() => _RegisterPoopPageState();
}

class _RegisterPoopPageState extends State<RegisterPoopPage>
    with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;
  final _formKey = GlobalKey<FormState>();
  String _feeling = '';

  double _lowerValue = 1;
  double _upperValue = 0;

  @override
  void initState() {
    super.initState();

    _motionTabBarController = MotionTabBarController(
      initialIndex: 2,
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  void _setFeeling(String feeling) {
    setState(() {
      _feeling = feeling;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Poop Page'),
      ),
      body: Stack(
        children: [
          SafeArea(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Enregistrement',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Voltaire',
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.purple[200],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 140,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Quantités',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Voltaire',
                                  ),
                                ),
                                const SizedBox(height: 5),
                                FlutterSlider(
                                  values: [_lowerValue],
                                  max: 10,
                                  min: 0,
                                  trackBar: FlutterSliderTrackBar(
                                    activeTrackBar: BoxDecoration(
                                      color: Colors
                                          .black, // Couleur de la barre active
                                    ),
                                    inactiveTrackBar: BoxDecoration(
                                      color: Colors.grey[
                                          200], // Couleur de la barre inactive
                                    ),
                                  ),
                                  handler: FlutterSliderHandler(
                                    decoration: BoxDecoration(
                                      color: Colors
                                          .purple[300], // Couleur du curseur
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.circle,
                                      color: Colors.purple[
                                          300], // Couleur de l'icône dans le curseur
                                      size: 10,
                                    ),
                                  ),
                                  onDragging:
                                      (handlerIndex, lowerValue, upperValue) {
                                    setState(() {
                                      _lowerValue =
                                          lowerValue; // Met à jour la valeur
                                    });
                                  },
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${_lowerValue.toInt()}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.purple[200],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 140,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Comment te sentais tu ?',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Voltaire',
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: Text('😊',
                                            style: TextStyle(fontSize: 30)),
                                        onPressed: () => _setFeeling('happy'),
                                      ),
                                      IconButton(
                                        icon: Text('😢',
                                            style: TextStyle(fontSize: 30)),
                                        onPressed: () => _setFeeling('sad'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.purple[200],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 140,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Un doute ? Une photo !',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Voltaire',
                                    ),
                                  ),
                                  const SizedBox(
                                      height:
                                          10), // Espacement entre le texte et l'icône
                                  GestureDetector(
                                    onTap: () async {
                                      // Naviguer vers la page CameraPreviewScreen
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CameraPreviewScreen(),
                                        ),
                                      );

                                      // Vous pouvez utiliser le résultat (chemin de l'image) ici si nécessaire
                                      if (result != null) {
                                        print(
                                            'Chemin de l\'image capturée : $result');
                                      }
                                    },
                                    child: Icon(
                                      Icons
                                          .camera_alt, // Icône représentant un appareil photo
                                      color: Colors.black,
                                      size: 40, // Taille de l'icône
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SavePoopButton(onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Envoyer les données au back
                            print("it's ok");
                          }
                        })
                      ],
                    ),
                  ))),
        ],
      ),
      bottomNavigationBar: NavBar(
        controller: _motionTabBarController!,
        onTabSelected: (int value) {
          setState(() {
            _motionTabBarController!.index = value;
          });
        },
      ),
    );
  }
}
