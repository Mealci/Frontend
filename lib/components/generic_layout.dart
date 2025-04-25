import 'package:flutter/material.dart';
import 'package:mealci/pages/health_report.dart';
import 'package:mealci/pages/poop_tracker_page.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'navbar.dart';
import '../pages/toilet_map_page.dart';
import '../pages/frigo_page.dart';
import '../pages/calendar_page.dart';

class GenericLayout extends StatefulWidget {
  final String? title;
  final Widget? child;

  const GenericLayout({super.key, this.title, this.child});

  @override
  State<GenericLayout> createState() => _GenericLayoutState();
}

class _GenericLayoutState extends State<GenericLayout>
    with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;
  Widget? _currentChild;

  @override
  void initState() {
    super.initState();

    _motionTabBarController = MotionTabBarController(
      initialIndex: 2,
      length: 4,
      vsync: this,
    );

    _currentChild = widget.child;
  }

  @override
  void dispose() {
    _motionTabBarController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentChild ??
          TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _motionTabBarController,
            children: <Widget>[
              const ToiletMapPage(),
              const PoopTrackerPage(),
              const FrigoPage(),
              const CalendarPage(),
              // const HealthReport(),
            ],
          ),
      bottomNavigationBar: NavBar(
        controller: _motionTabBarController!,
        onTabSelected: (int value) {
          setState(() {
            _currentChild = null;
            _motionTabBarController!.index = value;
          });
        },
      ),
    );
  }
}

class MainPageContentComponent extends StatelessWidget {
  final String title;

  const MainPageContentComponent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
