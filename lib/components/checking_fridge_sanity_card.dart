import 'package:flutter/material.dart';

class CheckingFridgeSanityCard extends StatelessWidget {
  final bool isFridgeSane;

  const CheckingFridgeSanityCard({super.key, required this.isFridgeSane});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Card(
          color: isFridgeSane ? Colors.green : Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  isFridgeSane
                      ? 'Zéro risque à l’horizon'
                      : 'Your fridge needs attention!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  isFridgeSane
                      ? 'Profitez en toute sérénité ! 😌'
                      : 'There are some issues that need to be fixed.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
