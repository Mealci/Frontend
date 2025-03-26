import 'package:flutter/material.dart';

class BristolScreen extends StatefulWidget {
  const BristolScreen({super.key});

  @override
  State<BristolScreen> createState() => _BristolScreenState();
}

class _BristolScreenState extends State<BristolScreen> {
  String? selectedValue = "Pas de caca";

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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Bristol", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.purple[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListView(
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
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  ),
                  Divider(color: Colors.purple[300]),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
