import 'dart:convert';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:mealci/services/event_service.dart';
import 'package:mealci/utils/styles/style.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final EventService eventService = EventService();
  DateTime selectedDate = DateTime.now();
  Map<String, dynamic> events = {};

  @override
  void initState() {
    super.initState();
    fetchEvents(selectedDate);
  }

  Future<void> fetchEvents(DateTime date) async {
    DateTime startDate = DateTime(date.year, date.month, date.day, 0, 0, 0);
    DateTime endDate = DateTime(date.year, date.month, date.day, 23, 59, 59);

    try {
      final Map<String, dynamic> fetchedEvents =
          await eventService.getAllEventsByDays(context, startDate, endDate);

      setState(() {
        events = fetchedEvents;
      });
    } catch (e) {
      setState(() {
        events = {};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      color: Style.styles[AppStyle.primaryColor],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 140,
                      child: CalendarTimeline(
                        initialDate: selectedDate,
                        firstDate: DateTime(DateTime.now().year - 1),
                        lastDate: DateTime(DateTime.now().year, 12, 31),
                        onDateSelected: (date) {
                          setState(() {
                            selectedDate = date;
                          });
                          fetchEvents(date); // Fetch events for selected date
                        },
                        leftMargin: 20,
                        monthColor: Colors.black,
                        dayColor: Colors.black,
                        dayNameColor: Colors.black,
                        activeDayColor: Colors.black,
                        activeBackgroundDayColor:
                            Style.styles[AppStyle.activeBackgroundDayColor],
                        selectableDayPredicate: (date) => date.day != 23,
                        locale: 'fr',
                        fontSize: 35,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: events.isEmpty
                        ? const Center(
                            child: Text(
                              'No events for this day.',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            itemCount:
                                events.length, // Compter le nombre d'événements
                            itemBuilder: (context, index) {
                              // Récupérer la date de l'événement (clé dans le Map)
                              String eventDate = events.keys.elementAt(index);

                              // Accéder à l'événement associé à cette date
                              var event = jsonEncode(events[eventDate]);

                              // Décoder le JSON en Map
                              var decodedEvent = jsonDecode(event);

                              // Récupérer la premier cles
                              var eventDat2 = decodedEvent.keys.elementAt(0);

                              var test = decodedEvent[eventDat2];

                              // Accéder aux poops et aux foods
                              List poops = test['poops'] ?? [];
                              List foods = test['foods'] ?? [];

                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Afficher la date de l'événement
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        eventDate.split("T")[
                                            0], // Afficher uniquement la date sans l'heure
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    // Afficher les poops s'ils existent
                                    if (poops.isNotEmpty)
                                      ...poops.map<Widget>((poop) {
                                        return Card(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          color: Colors.orange[50],
                                          child: ListTile(
                                            title: Text(
                                              'Stool Composition: ${poop['stoolComposition']}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                              'Quantity: ${poop['quantity']}',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    // Si pas de poops, afficher un message
                                    if (poops.isEmpty)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Text(
                                          'No poops recorded for this day.',
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        ),
                                      ),
                                    // Afficher les aliments s'ils existent
                                    if (foods.isNotEmpty)
                                      ...foods.map<Widget>((food) {
                                        return Card(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          color: Colors.green[50],
                                          child: ListTile(
                                            title: Text(
                                              'Food: $food',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    // Si pas d'aliments, afficher un message
                                    if (foods.isEmpty)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Text(
                                          'No foods available for this day.',
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
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
