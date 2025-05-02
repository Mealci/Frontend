import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealci/components/button_smocking_count.dart';
import 'package:mealci/components/button_waterclass_count.dart';
import 'package:mealci/components/save_poop_button.dart';
import 'package:mealci/utils/routes/routes.dart';
import 'package:mealci/utils/styles/style.dart';

class PoopTrackerPage extends StatefulWidget {
  const PoopTrackerPage({super.key});

  @override
  State<PoopTrackerPage> createState() => _PoopTrackerPageState();
}

class _PoopTrackerPageState extends State<PoopTrackerPage> {
  final DateTime lastPoopDate = DateTime(2025, 4, 29);

  String getPoopElapsedTime() {
    final now = DateTime.now();
    final duration = now.difference(lastPoopDate);

    if (duration.inHours >= 24) {
      final days = duration.inDays;
      return '$days jour${days > 1 ? 's' : ''}';
    } else {
      final hours = duration.inHours;
      return '$hours heure${hours > 1 ? 's' : ''}';
    }
  }

  Widget _buildIconBox(IconData icon, Color color) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Icon(icon, size: 50, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;
    final screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F1FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    'Journal Intestinal',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    '${getPoopElapsedTime()}\nDernière selle',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 80),
                  SvgPicture.asset(
                      CustomMealciAsset.toiletIcon,
                      height: screenH * 0.2,
                      width: screenW * 0.4,
                    ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WaterClassCountButton(),
                      const SizedBox(width: 20),
                      SmokingCountButton(),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SavePoopButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, Routes.registerPoopPage);
                    },
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}