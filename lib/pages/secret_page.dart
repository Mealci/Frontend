import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class HiddenPage extends StatefulWidget {
  const HiddenPage({super.key});

  @override
  State<HiddenPage> createState() => _HiddenPageState();
}

class _HiddenPageState extends State<HiddenPage> {
  static const int rows = 10;
  static const int columns = 10;
  static const int speed = 300;

  final Random random = Random();
  List<Offset> snake = [const Offset(5, 5)];
  Offset healthyFood = const Offset(2, 2);
  Offset badFood = const Offset(7, 7);
  String direction = "right";
  Timer? gameLoop;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    gameLoop = Timer.periodic(const Duration(milliseconds: speed), (timer) {
      setState(() {
        _moveSnake();
      });
    });
  }

  void _moveSnake() {
    Offset newHead;

    switch (direction) {
      case "up":
        newHead = Offset(snake.first.dx, snake.first.dy - 1);
        break;
      case "down":
        newHead = Offset(snake.first.dx, snake.first.dy + 1);
        break;
      case "left":
        newHead = Offset(snake.first.dx - 1, snake.first.dy);
        break;
      case "right":
      default:
        newHead = Offset(snake.first.dx + 1, snake.first.dy);
        break;
    }

    // Vérifier si le serpent sort de l'écran
    if (newHead.dx < 0 || newHead.dy < 0 || newHead.dx >= columns || newHead.dy >= rows) {
      _gameOver("💀 Tu t'es bloqué !");
      return;
    }

    if (newHead == healthyFood) {
      _spawnFood();
    } else if (newHead == badFood) {
      _gameOver("🍔 Trop de malbouffe, crise de MICI !");
      return;
    } else {
      snake.removeLast();
    }

    if (snake.contains(newHead)) {
      _gameOver("💀 Tu t'es mangé !");
      return;
    }

    snake.insert(0, newHead);
  }

  void _spawnFood() {
    Offset newHealthyFood = _generateNewFood();
    Offset newBadFood;

    do {
      newBadFood = _generateNewFood();
    } while (newBadFood == newHealthyFood); // S'assurer qu'ils sont différents

    healthyFood = newHealthyFood;
    badFood = newBadFood;
  }

  Offset _generateNewFood() {
    Offset position;
    do {
      position = Offset(random.nextInt(columns).toDouble(), random.nextInt(rows).toDouble());
    } while (snake.contains(position));
    return position;
  }

  void _gameOver(String reason) {
    gameLoop?.cancel();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("🚨 CRISE DE MICI"),
        content: Text(reason),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _restartGame();
            },
            child: const Text("🔄 Rejouer"),
          ),
        ],
      ),
    );
  }

  void _restartGame() {
    setState(() {
      snake = [const Offset(5, 5)];
      _spawnFood();
      direction = "right";
      _startGame();
    });
  }

  void _changeDirection(String newDirection) {
    if ((direction == "up" && newDirection == "down") ||
        (direction == "down" && newDirection == "up") ||
        (direction == "left" && newDirection == "right") ||
        (direction == "right" && newDirection == "left")) {
      return;
    }
    setState(() {
      direction = newDirection;
    });
  }

  @override
  void dispose() {
    gameLoop?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💩 Snake MICI Edition'),
        backgroundColor: Colors.brown,
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta! < 0) _changeDirection("up");
          if (details.primaryDelta! > 0) _changeDirection("down");
        },
        onHorizontalDragUpdate: (details) {
          if (details.primaryDelta! < 0) _changeDirection("left");
          if (details.primaryDelta! > 0) _changeDirection("right");
        },
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("🔥 Score : ${snake.length - 1}", style: const TextStyle(color: Colors.white, fontSize: 24)),
              Expanded(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                  ),
                  itemCount: rows * columns,
                  itemBuilder: (context, index) {
                    int x = index % columns;
                    int y = index ~/ columns;
                    Offset position = Offset(x.toDouble(), y.toDouble());

                    if (snake.first == position) {
                      return const Center(child: Text("💩", style: TextStyle(fontSize: 30))); // Tête du serpent
                    } else if (snake.contains(position)) {
                      return const Center(child: Text("🟫", style: TextStyle(fontSize: 25))); // Corps du serpent
                    } else if (position == healthyFood) {
                      return const Center(child: Text("🥦", style: TextStyle(fontSize: 30))); // Nourriture saine
                    } else if (position == badFood) {
                      return const Center(child: Text("🍔", style: TextStyle(fontSize: 30))); // Nourriture mauvaise
                    }
                    return const Center(child: Text("🟦", style: TextStyle(fontSize: 20))); // Fond du jeu
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('🚪 Quitter', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
