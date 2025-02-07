import 'package:flutter/material.dart';
import 'package:health/health.dart';

class TestHealthScreen extends StatefulWidget {
  const TestHealthScreen({super.key});

  @override
  _TestHealthScreenState createState() => _TestHealthScreenState();
}

class _TestHealthScreenState extends State<TestHealthScreen> {
  final Health health = Health();
  List<HealthDataPoint> _healthData = [];
  List<HealthDataType> availableTypes = [];

  @override
  void initState() {
    super.initState();
    fetchAvailableHealthData();
  }

  Future<void> fetchAvailableHealthData() async {
    List<HealthDataType> types = List.from(HealthDataType.values);
    List<HealthDataType> supportedTypes = [];
    
    for (var type in types) {
      bool isAvailable = health.isDataTypeAvailable(type);
      if (isAvailable) {
        supportedTypes.add(type);
      }
    }
    
    setState(() {
      availableTypes = supportedTypes;
    });
    fetchHealthData();
  }

  Future<void> fetchHealthData() async {
    if (availableTypes.isEmpty) return;
    
    List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
      startTime: DateTime.now().subtract(const Duration(days: 7)),
      endTime: DateTime.now(),
      types: availableTypes,
    );
    setState(() {
      _healthData = healthData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Health Screen'),
      ),
      body: _healthData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _healthData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_healthData[index].typeString),
                  subtitle: Text(
                      'Value: ${_healthData[index].value}, Date: ${_healthData[index].dateFrom}'),
                );
              },
            ),
    );
  }
}
