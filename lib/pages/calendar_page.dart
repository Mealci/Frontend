import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealci/components/counter_poop_calendar.dart';
import 'package:mealci/components/save_poop_button.dart';
import 'package:mealci/utils/styles/style.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    // Récupérer les dimensions de l'écran
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Calendrier',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Voltaire',
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFC1ADFF),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 140,
                      child: CalendarTimeline(
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year - 1,
                            DateTime.now().month, DateTime.now().day),
                        lastDate: DateTime(DateTime.now().year + 1,
                            DateTime.now().month, DateTime.now().day),
                        onDateSelected: (date) => print(date),
                        leftMargin: 20,
                        monthColor: Colors.black,
                        dayColor: Colors.black,
                        dayNameColor: Colors.black,
                        activeDayColor: Colors.black,
                        activeBackgroundDayColor: Color(0xFFE3BDFF),
                        selectableDayPredicate: (date) => date.day != 23,
                        locale: 'fr',
                        fontSize: 35,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  CounterPoopCalendar(),
                  SizedBox(height: screenHeight * 0.05),
                  SvgPicture.asset(
                    CustomMealciAsset.toiletIcon,
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.2,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  SavePoopButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Save Poop'),
                            content: const Text('Save Poop page'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
