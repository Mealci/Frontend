import 'package:flutter/material.dart';

class SmokingCountButton extends StatefulWidget {
  @override
  _SmokingCountButtonState createState() => _SmokingCountButtonState();
}

class _SmokingCountButtonState extends State<SmokingCountButton> with TickerProviderStateMixin {
  int currentCount = 0;
  late AnimationController _burnController;
  late Animation<double> _burnAnimation;

  late AnimationController _plusOneController;
  late Animation<double> _plusOneAnimation;

  @override
  void initState() {
    super.initState();

    _burnController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _burnAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _burnController, curve: Curves.easeInOut),
    );

    _plusOneController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _plusOneAnimation = Tween<double>(begin: 0, end: -30).animate(
      CurvedAnimation(parent: _plusOneController, curve: Curves.easeOut),
    );

    _burnController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _burnController.reset(); // reset to show a fresh cigarette
        });
      }
    });
  }

  void _onTap() {
    if (_burnController.isAnimating) return;

    setState(() {
      currentCount++;
    });

    _plusOneController.forward(from: 0.0);
    _burnController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _burnController.dispose();
    _plusOneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        width: 160,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2))
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Cigarette
            AnimatedBuilder(
              animation: _burnAnimation,
              builder: (context, child) {
                return Positioned(
                  left: 30,
                  child: Row(
                    children: [
                      Container(
                        width: 100 * _burnAnimation.value,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                        ),
                      ),
                      Container(
                        width: 10,
                        height: 20,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                );
              },
            ),
            // Counter
            Positioned(
              bottom: 10,
              child: Text(
                "$currentCount cigarettes",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            // +1 Animation
            AnimatedBuilder(
              animation: _plusOneAnimation,
              builder: (context, child) {
                return Positioned(
                  top: 20 + _plusOneAnimation.value,
                  child: Opacity(
                    opacity: 1 - (_plusOneAnimation.value / -30.0),
                    child: Text(
                      "+1",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
