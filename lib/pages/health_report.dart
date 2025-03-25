import 'dart:math';

import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:mealci/components/adaptative_square.dart';
import 'package:mealci/utils/styles/style.dart';

class HealthReport extends StatefulWidget {
  const HealthReport({super.key});

  @override
  State<HealthReport> createState() => _HealthReportState();
}

enum StressEnum {
  none,
  low,
  medium,
  high,
  veryHigh,
}

class _HealthReportState extends State<HealthReport> {
  final Health health = Health();

  Duration _totalSleep = Duration.zero;
  int _totalSteps = 0;
  StressEnum _stressLevel = StressEnum.none;
  double _averageHeartRate = 0;
  int _totalPoop = 0;
  int _qualityPoop = 0;
  int _totalCigarettes = 0;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDailyHealthData().then((_) {
      fetchDailyAPIData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  Future<void> fetchDailyHealthData() async {
    // Define the interval of time to get the data (24 hours)
    DateTime endTime = DateTime.now();
    DateTime startTime = endTime.subtract(const Duration(days: 1));

    // 1. Get and calculate total sleep
    List<HealthDataPoint> sleepData = await health.getHealthDataFromTypes(
      startTime: startTime,
      endTime: endTime,
      types: const [HealthDataType.SLEEP_ASLEEP],
    );
    Duration totalSleep = Duration.zero;
    for (var data in sleepData) {
      // The difference between dateTo and dateFrom is the duration of the sleep
      totalSleep += data.dateTo.difference(data.dateFrom);
    }

    // 2. Get number of steps
    List<HealthDataPoint> stepsData = await health.getHealthDataFromTypes(
      startTime: startTime,
      endTime: endTime,
      types: const [HealthDataType.STEPS],
    );

    int totalSteps = 0;
    for (var data in stepsData) {
      if (data.value is int) {
        totalSteps += data.value as int;
      } else if (data.value is double) {
        totalSteps += (data.value as double).toInt();
      } else if (data.value is NumericHealthValue) {
        totalSteps += (data.value as NumericHealthValue).numericValue.toInt();
      }
    }

    // 3. Get Average Heart Rate
    List<HealthDataPoint> heartRateData = await health.getHealthDataFromTypes(
      startTime: startTime,
      endTime: endTime,
      types: const [HealthDataType.HEART_RATE],
    );
    double totalHeartRate = 0;
    int heartRateCount = 0;
    for (var data in heartRateData) {
      if (data.value is num) {
        totalHeartRate += (data.value as num).toDouble();
        heartRateCount++;
      } else if (data.value is NumericHealthValue) {
        totalHeartRate += (data.value as NumericHealthValue).numericValue;
        heartRateCount++;
      }
    }
    double? averageHeartRate =
        heartRateCount > 0 ? totalHeartRate / heartRateCount : null;

    setState(() {
      _totalSleep = totalSleep;
      _totalSteps = totalSteps;
      _averageHeartRate = averageHeartRate ?? 0;
    });
  }

  Future<void> fetchDailyAPIData() async {
    // 4. Get Stress Level
    // TODO: implement API call to get stress level
    // Actually, we set with a random value
    // Generate a random number between 0 and 4
    int randomStressLevel = Random().nextInt(5);
    StressEnum stressLevel = StressEnum.values[randomStressLevel];

    // 5. Get Poop Data
    // TODO: implement API call to get poop data
    // Actually, we set with a random value
    // Generate a random number between 0 and 100
    int totalPoop = Random().nextInt(101);

    // 6. Get poop quality
    // TODO: implement API call to get poop quality
    // Actually, we set with a random value
    // Generate a random number between 1 and 7
    int qualityPoop = Random().nextInt(7) + 1;

    // 7. Get number of cigarettes
    // TODO: implement API call to get number of cigarettes
    // Actually, we set with a random value
    // Generate a random number between 0 and 300
    int totalCigarettes = Random().nextInt(301);

    setState(() {
      _stressLevel = stressLevel;
      _totalPoop = totalPoop;
      _qualityPoop = qualityPoop;
      _totalCigarettes = totalCigarettes;
    });
  }

  // Function to format the duration to a string
  String formatDuration(Duration d) {
    int hours = d.inHours;
    int minutes = d.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  // Function to get the emoji corresponding to the stress level
  String getStressEmoji(StressEnum stressLevel) {
    switch (stressLevel) {
      case StressEnum.none:
        return '😆';
      case StressEnum.low:
        return '😃';
      case StressEnum.medium:
        return '😐';
      case StressEnum.high:
        return '😟';
      case StressEnum.veryHigh:
        return '😫';
    }
  }

  // Return a random color
  Color getRandomColor() {
    var colors = [
      Style.styles[AppStyle.primaryColor].value ?? Colors.black,
      Style.styles[AppStyle.secondaryColor].value ?? Colors.black,
      Style.styles[AppStyle.thirdColor].value ?? Colors.black,
    ];

    return Color(colors[Random().nextInt(colors.length)]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Health Report 24 last hours'),
        // ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // 1 rectangle for total sleep
                      AdaptativeSquare(
                          data: 'Sommeil\n${formatDuration(_totalSleep)}',
                          backgroundColor: getRandomColor(),
                          isSquare: false),
                      // 2 square for stress level and total steps
                      Row(
                        children: [
                          Expanded(
                            child: AdaptativeSquare(
                                data: 'Stress\n${getStressEmoji(_stressLevel)}',
                                backgroundColor: getRandomColor(),
                                isSquare: true),
                          ),
                          Expanded(
                            child: AdaptativeSquare(
                                data: 'Nombres de pas\n$_totalSteps',
                                backgroundColor: getRandomColor(),
                                isSquare: true),
                          ),
                        ],
                      ),
                      // 1 rectangle for average heart rate
                      AdaptativeSquare(
                          data:
                              'Pulsation\n${_averageHeartRate.toInt().toString()} bpm en moyenne',
                          backgroundColor: getRandomColor(),
                          isSquare: false),
                      // 2 square for total poop and quality poop
                      Row(
                        children: [
                          Expanded(
                            child: AdaptativeSquare(
                                data: 'Nombre de\nscelles\n$_totalPoop',
                                backgroundColor: getRandomColor(),
                                isSquare: true),
                          ),
                          Expanded(
                            child: AdaptativeSquare(
                                data: 'Qualité des\nscelles\n$_qualityPoop',
                                backgroundColor: getRandomColor(),
                                isSquare: true),
                          ),
                        ],
                      ),
                      // 1 rectangle for total cigarettes
                      AdaptativeSquare(
                          data: 'Nombre de cigarettes\n$_totalCigarettes',
                          backgroundColor: getRandomColor(),
                          isSquare: false),
                    ],
                  ),
                ),
              ));
  }
}
