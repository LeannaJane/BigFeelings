import 'dart:ui';

enum CardState { hidden, visible, guessed }

class CardItem {
  final int value;
  final String imagePath;
  Color color;
  CardState state;

  CardItem({
    required this.value,
    required this.imagePath,
    required this.color,
    this.state = CardState.hidden,
  });
}
