import 'package:flutter/material.dart';
import '../components/generic_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return const GenericLayout(
      title: 'Home',
    );
  }
}
