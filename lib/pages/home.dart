import 'package:flutter/material.dart';
import '../components/generic_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const GenericLayout(
      title: 'Home',
    );
  }
}
