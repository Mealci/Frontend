import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'navbar.dart';
import '../pages/toilet_map_page.dart';

class GenericLayout extends StatefulWidget {
  const GenericLayout({super.key, this.title});

  final String? title;

  @override
  State<GenericLayout> createState() => _GenericLayoutState();
}

class _GenericLayoutState extends State<GenericLayout>
    with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();

    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _motionTabBarController,
        children: <Widget>[
          MainPageContentComponent(
              title: "Recipes Page", controller: _motionTabBarController!),
          const ToiletMapPage(),
          MainPageContentComponent(
              title: "Mealci Page", controller: _motionTabBarController!),
          MainPageContentComponent(
              title: "Calendar Page", controller: _motionTabBarController!),
          MainPageContentComponent(
              title: "Chart Page", controller: _motionTabBarController!)
        ],
      ),
      bottomNavigationBar: NavBar(
        controller: _motionTabBarController!,
        onTabSelected: (int value) {
          setState(() {
            _motionTabBarController!.index = value;
          });
        },
      ),
    );
  }
}

class MainPageContentComponent extends StatelessWidget {
  const MainPageContentComponent({
    required this.title,
    required this.controller,
    super.key,
  });

  final String title;
  final MotionTabBarController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
