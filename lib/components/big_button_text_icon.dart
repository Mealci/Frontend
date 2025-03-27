import 'package:flutter/material.dart';
import 'package:mealci/utils/i18N/i18n.dart';
import 'package:mealci/utils/styles/style.dart';

class BigTextAndIconButton extends StatelessWidget {
  final dynamic label;
  final Map<dynamic, String> map;
  final IconData icon;
  final VoidCallback? onPressed;

  const BigTextAndIconButton({
    required this.label,
    required this.map,
    this.icon = Icons.abc_rounded,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Le bouton prend toute la largeur
      height: 70, // Bouton plus grand
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(
              Style.styles[AppStyle.activeBackgroundDayColor].value ??
                  Colors.black),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        onPressed: onPressed ?? () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color:
                  Color(Style.styles[AppStyle.textColor].value ?? Colors.white),
              size: 30,
            ),
            const SizedBox(width: 15),
            Text(
              I18n.getTranslation(map, label) ?? '',
              style: Style.styles[AppStyle.buttonTextStyle],
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
