import 'package:flutter/material.dart';
import 'package:mealci/utils/I18N/I18n.dart';
import 'package:mealci/utils/style.dart';

class ButtonPadding extends StatelessWidget {
  final dynamic label;
  final Map<dynamic, String> map;
  final EdgeInsets padding;
  final int icon;

  const ButtonPadding({
    required this.label,
    required this.map,
    required this.padding,
    this.icon = 0x0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC1A4F7),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              IconData(icon, fontFamily: 'MaterialIcons'),
              color: Style.styles[AppStyle.textColor],
            ),
            SizedBox(width: icon == 0x0 ? 0 : 32),
            Text(
              I18n.getTranslation(map, label) ?? '',
              style: TextStyle(
                color: Style.styles[AppStyle.textColor],
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}