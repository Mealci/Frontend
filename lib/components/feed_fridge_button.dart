import 'package:flutter/material.dart';
import '../utils/styles/style.dart';

class FeedFridgeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const FeedFridgeButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(1000, 35),
          backgroundColor: Style.styles[AppStyle.primaryColor],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 16,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16),
            Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
