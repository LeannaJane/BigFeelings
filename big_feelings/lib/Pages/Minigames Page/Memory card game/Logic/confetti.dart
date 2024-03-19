import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class GameConfetti extends StatefulWidget {
  const GameConfetti({
    super.key,
  });

  @override
  State<GameConfetti> createState() => _GameConfettiState();
}

class _GameConfettiState extends State<GameConfetti> {
  final controllerCenter =
      ConfettiController(duration: const Duration(seconds: 10));

  @override
  void initState() {
    super.initState();
    controllerCenter.play();
  }

  @override
  void dispose() {
    controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: controllerCenter,
        blastDirectionality: BlastDirectionality.explosive,
        shouldLoop: false,
        gravity: 0.6,
        emissionFrequency: 0.05,
        numberOfParticles: 30,
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.pink,
          Colors.orange,
          Colors.purple,
          Colors.yellow,
          Colors.blueGrey
        ],
      ),
    );
  }
}
