import 'package:flutter/material.dart';

class HealthStat {
  final String label;
  final String value;
  final bool isSquare;
  final IconData icon;
  List<Color> gradientColors;

  HealthStat({
    required this.label,
    required this.value,
    this.isSquare = false,
    required this.icon,
    this.gradientColors = const [
      Colors.black,
      Colors.white
    ], // Valeurs par défaut
  });
}
