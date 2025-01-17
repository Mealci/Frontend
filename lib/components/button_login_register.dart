import 'package:flutter/material.dart';
import 'package:mealci/utils/I18N/i18n.dart';
import 'package:mealci/utils/styles/style.dart';

class Buttonloginregister extends StatelessWidget {
  final dynamic label;
  final Map<dynamic, String> map;
  final VoidCallback? onPressed;

  const Buttonloginregister({
    required this.label,
    required this.map,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Style.styles[AppStyle.secondaryColor],
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text(
        I18n.getTranslation(map, label) ?? '',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
