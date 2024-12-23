// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:big_feelings/Pages/Minigames%20Page/Memory%20card%20game/Logic/card.dart';

class MemoryCard extends StatelessWidget {
  final int index;
  final CardItem card;
  final void Function(int) onCardPressed;
  final Color frontColor;
  final bool isPaused;
  final double cardSize;
  final Color backColor;

  const MemoryCard({
    required this.index,
    required this.card,
    required this.onCardPressed,
    this.frontColor = Colors.blue,
    required this.isPaused,
    required this.backColor,
    this.cardSize = 100.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isPaused ? null : () => onCardPressed(index),
      child: SizedBox(
        width: cardSize,
        height: cardSize,
        child: FlipCard(
          flipOnTouch: false,
          front: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: card.state == CardState.hidden ? backColor : frontColor,
            child: Center(
              child: card.state == CardState.hidden
                  ? Container()
                  : Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          card.imagePath,
                          width: cardSize - 30,
                          height: cardSize - 30,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
            ),
          ),
          back: SizedBox(
            width: cardSize,
            height: cardSize,
          ),
        ),
      ),
    );
  }
}
