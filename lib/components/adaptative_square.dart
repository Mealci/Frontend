import 'package:flutter/material.dart';

class AdaptativeSquare extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final List<Color> gradientColors;
  final bool isSquare;

  const AdaptativeSquare({
    super.key,
    required this.value,
    required this.label,
    required this.gradientColors,
    this.icon = Icons.question_mark,
    this.isSquare = false,
  });

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    final gradient = LinearGradient(
      colors: gradientColors,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final cardContent = Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20 * textScaleFactor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );

    return isSquare
        ? Expanded(child: AspectRatio(aspectRatio: 1.0, child: cardContent))
        : SizedBox(width: double.infinity, child: cardContent);
  }
}
