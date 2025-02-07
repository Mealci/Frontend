import 'package:flutter/material.dart';
import 'package:mealci/utils/styles/style.dart';

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
              'Caca',
              style: TextStyle(
                color: Style.styles[AppStyle.textColor],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$counter',
              style: TextStyle(
                color: Style.styles[AppStyle.textColor],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${date.day}/${date.month}/${date.year}',
              style: TextStyle(
                color: Style.styles[AppStyle.textColor],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
