import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/scheduler.dart';

class WaterClassCountButton extends StatefulWidget {
  const WaterClassCountButton({super.key});

  @override
  _WaterClassCountButtonState createState() => _WaterClassCountButtonState();
}

class _WaterClassCountButtonState extends State<WaterClassCountButton> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Ticker _ticker;
  late ConfettiController _confettiController;


  int goal = 8;
  int currentCount = 0;
   double waveOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 0.0).animate(_controller);
    _ticker = createTicker((elapsed) {
      setState(() {
        waveOffset += 0.1;
      });
    });
    _ticker.start();
  }

  void _onTap() {
    if (currentCount < goal) {
      setState(() {
        currentCount++;
        double newProgress = currentCount / goal;
        _animation = Tween<double>(begin: _animation.value, end: newProgress).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
        _controller.forward(from: 0.0);
        if (currentCount == goal) {
          _confettiController.play();
      }
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 150,
          height: 100,
          color: Colors.blue.shade100,
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipPath(
                      clipper: WaveClipper(_animation.value, waveOffset),
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        color: Colors.blue,
                      ),
                    ),
                  );
                },
              ),
              Center(
                child: Text(
                  "$currentCount / $goal",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [Colors.blue, Colors.green, Colors.purple, Colors.pink, Colors.orange],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _ticker.stop();
    _ticker.dispose();
    _confettiController.dispose();
    _confettiController.dispose();
    super.dispose();
  }
}


class WaveClipper extends CustomClipper<Path> {
  final double progress;
  final double waveOffset;

  WaveClipper(this.progress, this.waveOffset);

  @override
  Path getClip(Size size) {
    final path = Path();
    double waterLevel = size.height * (1 - progress);

    path.moveTo(0, waterLevel);
    for (double i = 0.0; i <= size.width; i++) {
      path.lineTo(i, waterLevel + sin((i / 20) + waveOffset) * 5);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) => true;
}
