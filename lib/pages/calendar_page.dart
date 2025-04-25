import 'dart:convert';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:mealci/models/poop_enums.dart';
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
  int eventsNumber = 0; // Variable pour stocker le nombre d'événements

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

      int totalEvents = 0;

      fetchedEvents.forEach((key, value) {
        var decodedEvent = jsonDecode(jsonEncode(value));
        var firstKey = decodedEvent.keys.first;
        var test = decodedEvent[firstKey];

        List poops = test['poops'] ?? [];
        List foods = test['foods'] ?? [];

        totalEvents += poops.length + foods.length;
      });

      setState(() {
        events = fetchedEvents;
        eventsNumber = totalEvents; // Met à jour le nombre d'événements
      });
    } catch (e) {
      setState(() {
        events = {};
        eventsNumber = 0; // Réinitialise à 0 en cas d'erreur
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
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Style.styles[AppStyle.primaryColor],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 150,
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
                        locale: 'fr',
                        fontSize: 35,
                        dotNumber: eventsNumber,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: events.isEmpty
                        ? const Center(
                            child: Text(
                              'Pas d\'événements enregistrés pour cette date.',
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

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Afficher les poops s'ils existent
                                  if (poops.isNotEmpty)
                                    ...poops.map<Widget>((poop) {
                                      return Card(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        color: Colors.orange[50],
                                        child: ListTile(
                                          title: Text(
                                            'Aspect: ${getPoopDescription(StoolComposition.values.firstWhere((e) => e.toString() == 'StoolComposition.${poop['stoolComposition']}', orElse: () => StoolComposition.TYPE_UNKNOWN))}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            'Quantité: ${poop['quantity']}',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      );
                                    }),
                                  // Si pas de poops, afficher un message
                                  if (poops.isEmpty)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Text(
                                        'Pas de selles enregistrées.',
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
                                            food['name'] != null
                                                ? utf8.decode(food['name']
                                                    .toString()
                                                    .codeUnits)
                                                : 'Aliment non spécifié',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            'Quantité: ${food['quantity']?.toString() ?? ''} ${food['measure'] ?? ''}',
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      );
                                    }),
                                  // Si pas d'aliments, afficher un message
                                  if (foods.isEmpty)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Text(
                                        'Pas d\'aliments enregistrés.',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                      ),
                                    ),
                                ],
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

  String getPoopDescription(StoolComposition stoolComposition) {
    switch (stoolComposition) {
      case StoolComposition.TYPE_ONE:
        return 'Des petites boules dures';
      case StoolComposition.TYPE_TWO:
        return 'Une petite boule';
      case StoolComposition.TYPE_THREE:
        return 'Une saucisse';
      case StoolComposition.TYPE_FOUR:
        return 'Une saucisse lisse';
      case StoolComposition.TYPE_FIVE:
        return 'Mou';
      case StoolComposition.TYPE_SIX:
        return 'Mou avec morceaux';
      case StoolComposition.TYPE_SEVEN:
        return 'Liquide';
      default:
        return 'Inconnu';
    }
  }
}
