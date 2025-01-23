import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealci/utils/styles/style.dart';


class ButtonProfile extends StatelessWidget {
  final VoidCallback onPressed;

  const ButtonProfile({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Style.styles[AppStyle.secondaryColor],
        fixedSize: const Size(60, 60),
        shape: const CircleBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      ),
      child: SvgPicture.asset(
        width: 40,
        height: 40,
        CustomMealciAsset.profileIcon,
      )
    );
  }
}