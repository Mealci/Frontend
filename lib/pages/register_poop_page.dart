import 'package:flutter/material.dart';
import 'package:mealci/components/camera_preview_screen.dart';
import 'package:mealci/components/custom_snak_bar.dart';
import 'package:mealci/components/save_poop_button.dart';
import 'package:mealci/models/poop_enums.dart';
import 'package:mealci/models/poop_model.dart';
import 'package:mealci/services/poop_service.dart';
import 'package:mealci/utils/routes/routes.dart';
import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/trackbar.dart';
import 'package:another_xlider/models/handler.dart';

class RegisterPoopPage extends StatefulWidget {
  const RegisterPoopPage({super.key});

  @override
  State<RegisterPoopPage> createState() => _RegisterPoopPageState();
}

class _RegisterPoopPageState extends State<RegisterPoopPage> {
  final _formKey = GlobalKey<FormState>();
  String _feeling = '';
  double _lowerValue = 1;
  String? _selectedBristolType = "Pas de caca";
  List<String> _selectedSymptoms = [];
  final PoopService _poopService = PoopService();

  // Méthode pour valider le formulaire
  String? _validateQuantity(double value) {
    if (value == 0) {
      return 'La quantité ne peut pas être zéro';
    }
    return null;
  }

  String? _validateFeeling(String feeling) {
    if (feeling.isEmpty) {
      return 'Veuillez sélectionner un ressenti';
    }
    return null;
  }

  // Méthode pour transforer les données stoolcomposition
  StoolComposition _getStoolComposition(String value) {
    switch (value) {
      case "Pas de caca":
        return StoolComposition.TYPE_NONE;
      case "Inconnue":
        return StoolComposition.TYPE_UNKNOWN;
      case "Bristol 1":
        return StoolComposition.TYPE_ONE;
      case "Bristol 2":
        return StoolComposition.TYPE_TWO;
      case "Bristol 3":
        return StoolComposition.TYPE_THREE;
      case "Bristol 4":
        return StoolComposition.TYPE_FOUR;
      case "Bristol 5":
        return StoolComposition.TYPE_FIVE;
      case "Bristol 6":
        return StoolComposition.TYPE_SIX;
      case "Bristol 7":
        return StoolComposition.TYPE_SEVEN;
      default:
        return StoolComposition.TYPE_UNKNOWN;
    }
  }

  // Méthode pour enregistrer les données feedling
  Feeling _getFeeling(String value) {
    switch (value) {
      case "Très bien":
        return Feeling.VERY_GOOD;
      case "Bien":
        return Feeling.GOOD;
      case "Moyen":
        return Feeling.OK;
      case "Mal":
        return Feeling.BAD;
      case "Très mal":
        return Feeling.VERY_BAD;
      default:
        return Feeling.OK;
    }
  }

  void _savePoopData() {
    if (_validateFeeling(_feeling) != null ||
        _validateQuantity(_lowerValue) != null) {
        CustomSnackBar.showError(context, "Veuillez remplir les champs Quantité, Bristol et Ressenti");
    } else {
      // Création de l'objet Poop
      Poop poop = Poop(
        stoolComposition: _getStoolComposition(_selectedBristolType!),
        quantity: _lowerValue.toInt(),
        feeling: _getFeeling(_feeling),
        hasExcessiveFlatulence:
            _selectedSymptoms.contains("Flatulence Excessives") ? true : false,
        hasPain: _selectedSymptoms.contains("Douleur") ? true : false,
        hasMucus: _selectedSymptoms.contains("Mucus") ? true : false,
        hasFoodResidue:
            _selectedSymptoms.contains("Reste de Nourriture") ? true : false,
        hasColic: _selectedSymptoms.contains("Coliques") ? true : false,
        hasAbdominalBloating:
            _selectedSymptoms.contains("Ballonnement") ? true : false,
        hasUnusualSmells:
            _selectedSymptoms.contains("Odeur Anormale") ? true : false,
      );

      // Enregistrement des données
      _poopService.createPoop(context, poop);

      // Réinitialisation des valeurs
      setState(() {
        _lowerValue = 1;
        _feeling = '';
        _selectedBristolType = "Pas de caca";
        _selectedSymptoms = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.home);
                          },
                        ),
                        Spacer(),
                        Text(
                          'Enregistrement',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Voltaire',
                          ),
                        ),
                        Spacer(flex: 2),
                      ],
                    ),
                    const SizedBox(height: 20),
                    QuantitySlider(
                      value: _lowerValue,
                      onChanged: (newValue) {
                        setState(() {
                          _lowerValue = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    FeelingSelector(
                      selectedFeeling: _feeling,
                      onFeelingSelected: (feeling) {
                        setState(() {
                          _feeling = feeling;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    BristolSelection(
                      selectedValue: _selectedBristolType,
                      onChanged: (value) {
                        setState(() {
                          _selectedBristolType = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    SymptomsSelection(
                      selectedSymptoms: _selectedSymptoms,
                      onChanged: (newSelectedSymptoms) {
                        setState(() {
                          _selectedSymptoms = newSelectedSymptoms;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    PhotoCapture(),
                    const SizedBox(height: 20),
                    SavePoopButton(onPressed: _savePoopData)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuantitySlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const QuantitySlider(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              values: [value],
              max: 10,
              min: 0,
              trackBar: FlutterSliderTrackBar(
                activeTrackBar: BoxDecoration(color: Colors.black),
                inactiveTrackBar: BoxDecoration(color: Colors.grey[200]),
              ),
              handler: FlutterSliderHandler(
                decoration: BoxDecoration(
                  color: Colors.purple[300],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.circle, color: Colors.purple[300], size: 10),
              ),
              onDragging: (handlerIndex, lowerValue, upperValue) {
                onChanged(lowerValue);
              },
            ),
            const SizedBox(height: 2),
            Text(
              '${value.toInt()}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BristolSelection extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  BristolSelection(
      {super.key, required this.selectedValue, required this.onChanged});

  final List<Map<String, String>> bristolOptions = [
    {"label": "Pas de caca", "description": "N’a pas fait caca"},
    {"label": "Inconnue", "description": "Pas vu"},
    {
      "label": "Bristol 1",
      "description":
          "Petites crottes dures et détachées, ressemblant à des noisettes"
    },
    {
      "label": "Bristol 2",
      "description": "En forme de saucisse, mais dures et grumeleuses"
    },
    {
      "label": "Bristol 3",
      "description":
          "Comme une saucisse, mais avec des craquelures sur la surface"
    },
    {
      "label": "Bristol 4",
      "description": "Ressemble à une saucisse ou un serpent, lisse et douce"
    },
    {"label": "Bristol 5", "description": "Morceaux mous, avec des bords nets"},
    {
      "label": "Bristol 6",
      "description": "Morceaux duveteux, en lambeaux, selles détrempées"
    },
    {
      "label": "Bristol 7",
      "description": "Pas de morceau solide, entièrement liquide"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(16),
        children: bristolOptions.map((option) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioListTile<String>(
                activeColor: Colors.purple,
                title: Text(
                  option["label"]!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(option["description"]!),
                value: option["label"]!,
                groupValue: selectedValue,
                onChanged: onChanged,
              ),
              Divider(color: Colors.purple[300]),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class FeelingSelector extends StatelessWidget {
  final ValueChanged<String> onFeelingSelected;
  final String selectedFeeling;

  const FeelingSelector(
      {super.key,
      required this.onFeelingSelected,
      required this.selectedFeeling});

  final List<Map<String, String>> feelings = const [
    {'emoji': '😄', 'label': 'Très bien'},
    {'emoji': '😊', 'label': 'Bien'},
    {'emoji': '😐', 'label': 'Moyen'},
    {'emoji': '😟', 'label': 'Mal'},
    {'emoji': '😭', 'label': 'Très mal'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple[200],
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Comment te sentais-tu ?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Voltaire',
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: feelings.map((feeling) {
              bool isSelected = feeling['label'] == selectedFeeling;
              return GestureDetector(
                onTap: () => onFeelingSelected(feeling['label']!),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.black : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    feeling['emoji']!,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class PhotoCapture extends StatelessWidget {
  const PhotoCapture({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CameraPreviewScreen(),
                    ),
                  );
                  if (result != null) {
                    debugPrint('Chemin de l\'image capturée : $result');
                  }
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SymptomsSelection extends StatelessWidget {
  final List<String> selectedSymptoms;
  final ValueChanged<List<String>> onChanged;

  final List<String> symptoms = [
    "Flatulence Excessives",
    "Douleur",
    "Ballonnement",
    "Mucus",
    "Reste de Nourriture",
    "Coliques",
    "Odeur Anormale",
  ];

  SymptomsSelection(
      {super.key, required this.selectedSymptoms, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple[100],
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(25),
      child: Column(
        children: symptoms.map((symptom) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                activeColor: Colors.purple,
                value: selectedSymptoms.contains(symptom),
                onChanged: (bool? value) {
                  if (value != null) {
                    // Si la case est cochée, on ajoute le symptôme à la liste
                    if (value) {
                      selectedSymptoms.add(symptom);
                    } else {
                      selectedSymptoms.remove(symptom);
                    }
                    onChanged(List.from(
                        selectedSymptoms)); // Passer une copie de la liste
                  }
                },
              ),
              SizedBox(width: 10),
              Text(
                symptom,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
