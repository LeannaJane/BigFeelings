import 'package:big_feelings/Pages/Minigames%20Page/Memory%20card%20game/Logic/card.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class MemoryCard extends StatelessWidget {
  final int index;
  final CardItem card;
  final void Function(int) onCardPressed;
  final Color frontColor;
  final bool isPaused;

  const MemoryCard({
    required this.index,
    required this.card,
    required this.onCardPressed,
    this.frontColor = Colors.blue,
    required this.isPaused,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isPaused
          ? null
          : () => onCardPressed(index), // Disable tap when game is paused
      child: FlipCard(
        flipOnTouch: false,
        front: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: card.state == CardState.hidden ? Colors.pink : frontColor,
          child: Center(
            child: card.state == CardState.hidden
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2.0),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          card.imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
        back: const Card(),
      ),
    );
  }
}
