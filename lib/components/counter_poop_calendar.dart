import 'package:flutter/material.dart';

class CounterPoopCalendar extends StatelessWidget {
  final int counter;
  final DateTime date;

  const CounterPoopCalendar(
      {super.key, required this.counter, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFC1ADFF),
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '💩  Aujourd’hui : Aucune selle  💩',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
