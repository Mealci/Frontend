import 'dart:math';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:mealci/components/adaptative_square.dart';
import 'package:mealci/models/health_stats.dart';
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

class _HealthReportState extends State<HealthReport> with SingleTickerProviderStateMixin {
  final Health health = Health();

  Duration _totalSleep = Duration.zero;
  int _totalSteps = 0;
  StressEnum _stressLevel = StressEnum.none;
  double _averageHeartRate = 0;
  int _totalPoop = 0;
  int _qualityPoop = 0;
  int _totalCigarettes = 0;

  bool _isLoading = true;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
    _colorAnimation = ColorTween(
      begin: Style.styles[AppStyle.primaryColor],
      end: Style.styles[AppStyle.thirdColor],
    ).animate(_controller);
    
    fetchDailyHealthData().then((_) {
      fetchDailyAPIData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchDailyHealthData() async {
    DateTime endTime = DateTime.now();
    DateTime startTime = endTime.subtract(const Duration(days: 1));

    // Récupération du sommeil
    List<HealthDataPoint> sleepData = await health.getHealthDataFromTypes(
      startTime: startTime,
      endTime: endTime,
      types: const [HealthDataType.SLEEP_ASLEEP],
    );
    Duration totalSleep = Duration.zero;
    for (var data in sleepData) {
      totalSleep += data.dateTo.difference(data.dateFrom);
    }

    // Récupération des pas
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

    // Récupération de la pulsation (heart rate)
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
    double? averageHeartRate = heartRateCount > 0 ? totalHeartRate / heartRateCount : null;

    setState(() {
      _totalSleep = totalSleep;
      _totalSteps = totalSteps;
      _averageHeartRate = averageHeartRate ?? 0;
    });
  }

  Future<void> fetchDailyAPIData() async {
    int randomStressLevel = Random().nextInt(5);
    StressEnum stressLevel = StressEnum.values[randomStressLevel];

    int totalPoop = Random().nextInt(101);
    int qualityPoop = Random().nextInt(7) + 1;
    int totalCigarettes = Random().nextInt(301);

    setState(() {
      _stressLevel = stressLevel;
      _totalPoop = totalPoop;
      _qualityPoop = qualityPoop;
      _totalCigarettes = totalCigarettes;
    });
  }

  String formatDuration(Duration d) {
    int hours = d.inHours;
    int minutes = d.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

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

  // Génère une séquence de couleurs animées basée sur _colorAnimation
  List<Color> getAnimatedGradientSequence() {
    Color base = _colorAnimation.value ?? Style.styles[AppStyle.primaryColor];
    HSLColor hsl = HSLColor.fromColor(base);
    return [
      hsl.withHue((hsl.hue + 0) % 360).toColor(),
      hsl.withHue((hsl.hue + 15) % 360).toColor(),
      hsl.withHue((hsl.hue + 30) % 360).toColor(),
      hsl.withHue((hsl.hue + 45) % 360).toColor(),
      hsl.withHue((hsl.hue + 60) % 360).toColor(),
    ];
  }

  List<HealthStat> getHealthStats() {
    // Utilise la séquence de couleurs animée
    List<Color> gradientSequence = getAnimatedGradientSequence();

    List<HealthStat> stats = [
      HealthStat(
        label: 'Sommeil',
        value: formatDuration(_totalSleep),
        isSquare: false,
        icon: Icons.bedtime,
      ),
      HealthStat(
        label: 'Nombres de pas',
        value: _totalSteps.toString(),
        isSquare: false,
        icon: Icons.directions_walk,
      ),
      HealthStat(
        label: 'Pulsation',
        value: '${_averageHeartRate.toInt()} bpm',
        isSquare: true,
        icon: Icons.favorite,
      ),
      HealthStat(
        label: 'Stress',
        value: getStressEmoji(_stressLevel),
        isSquare: true,
        icon: Icons.sentiment_very_dissatisfied,
      ),
      HealthStat(
        label: 'Nombre de selles',
        value: _totalPoop.toString(),
        isSquare: false,
        icon: Icons.wc,
      ),
      HealthStat(
        label: 'Qualité des selles',
        value: _qualityPoop.toString(),
        isSquare: false,
        icon: Icons.high_quality,
      ),
      HealthStat(
        label: 'Nombre de cigarettes',
        value: _totalCigarettes.toString(),
        isSquare: false,
        icon: Icons.smoking_rooms,
      ),
    ];

    // Attribution du dégradé vertical et synchronisation des paires
    for (int i = 0; i < stats.length; i++) {
      if (i < gradientSequence.length - 1) {
        stats[i].gradientColors = [
          gradientSequence[i],
          gradientSequence[i + 1],
        ];
      } else {
        stats[i].gradientColors = [
          gradientSequence[i % gradientSequence.length],
          gradientSequence[(i + 1) % gradientSequence.length],
        ];
      }

      // Si c'est une tuile carrée, lui et la tuile suivante partagent le même dégradé
      if (stats[i].isSquare && i + 1 < stats.length && stats[i + 1].isSquare) {
        stats[i + 1].gradientColors = stats[i].gradientColors;
        i++; // On saute une itération pour ne pas changer la couleur du pair
      }
    }

    return stats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.styles[AppStyle.backgroundColor],
      // appBar: AppBar(
      //   title: const Text("Health Report"),
      //   backgroundColor: Style.styles[AppStyle.primaryColor],
      // ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List<HealthStat> stats = getHealthStats();
            List<Widget> widgets = [];
            List<Widget> rowBuffer = [];

            for (var stat in stats) {
              Widget square = AdaptativeSquare(
                value: stat.value,
                label: stat.label,
                icon: stat.icon,
                gradientColors: stat.gradientColors,
                isSquare: stat.isSquare,
              );
              if (stat.isSquare) {
                rowBuffer.add(square);
                if (rowBuffer.length == 2) {
                  widgets.add(Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: rowBuffer,
                  ));
                  rowBuffer = [];
                }
              } else {
                if (rowBuffer.isNotEmpty) {
                  widgets.add(rowBuffer.removeAt(0));
                }
                widgets.add(square);
              }
            }
            if (rowBuffer.isNotEmpty) {
              widgets.add(rowBuffer.removeAt(0));
            }

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Rapport Santé',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Voltaire',
                      ),
                    ),
                    Column(children: widgets),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
