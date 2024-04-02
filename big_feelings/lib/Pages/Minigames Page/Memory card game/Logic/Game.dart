// ignore: file_names
import 'dart:math';
import 'package:big_feelings/Pages/Minigames%20Page/Memory%20card%20game/Logic/card.dart';
import 'package:flutter/material.dart';

class Game with ChangeNotifier {
  late List<CardItem> cards;
  bool isGameOver = false;
  late List<String> imagePaths;
  bool _processing = false;
  final List<int> _visibleCardIndexes = [];
  late int gridSize;

  Game() {
    gridSize = 6;
    generateCardsAndImages();
  }

  void generateCardsAndImages() {
    imagePaths = [];
    List<String> imagePathsList = [
      'assets/images/images_mood/happy.png',
      'assets/images/images_mood/sad.png',
      'assets/images/images_mood/angry.png',
      'assets/images/images_mood/surprised.png',
      'assets/images/images_mood/ok.png',
      'assets/images/images_mood/overwhelmed.png',
      'assets/images/images_mood/sick.png',
      'assets/images/images_mood/silly.png',
      'assets/images/images_mood/tired.png',
      'assets/images/images_mood/unhappy.png',
      'assets/images/images_mood/upset.png',
      'assets/images/images_mood/lonely.png',
    ];

    cards = [];
    List<Color> cardColors = [
      const Color.fromARGB(255, 0, 92, 167),
      Colors.green,
      Colors.purple,
      const Color.fromARGB(255, 63, 250, 231),
      const Color.fromARGB(255, 188, 243, 136),
      const Color.fromARGB(255, 115, 187, 253),
      const Color.fromARGB(255, 126, 243, 126),
      const Color.fromARGB(255, 165, 188, 253),
      const Color.fromARGB(255, 250, 122, 122),
      const Color.fromARGB(255, 253, 227, 108),
      const Color.fromARGB(255, 247, 140, 90),
      const Color.fromARGB(255, 239, 129, 253),
    ];
    cardColors.shuffle(Random());

    int totalCardsNeeded = 4 * 6 ~/ 2;

    for (int j = 0; j < totalCardsNeeded; j++) {
      String imagePath = imagePathsList[j % imagePathsList.length];
      imagePaths.add(imagePath);
      int cardValue = j + 1;
      Color assignedColor = cardColors[j % cardColors.length];
      List<CardItem> newCards =
          _createCardItems(imagePath, assignedColor, cardValue);
      cards.addAll(newCards);
    }

    cards.shuffle(Random());
  }

  void resetGame() {
    generateCardsAndImages();
    isGameOver = false;
    _visibleCardIndexes.clear();
    _processing = false;
  }

  void onCardPressed(int index) {
    if (!isGameOver) {
      if (_processing) return;
      _processing = true;

      CardItem tappedCard = cards[index];

      if (tappedCard.state != CardState.hidden) {
        _processing = false;
        return;
      }

      tappedCard.state = CardState.visible;
      _visibleCardIndexes.add(index);

      if (_visibleCardIndexes.length == 2) {
        int firstIndex = _visibleCardIndexes[0];
        int secondIndex = _visibleCardIndexes[1];

        CardItem firstCard = cards[firstIndex];
        CardItem secondCard = cards[secondIndex];

        if (firstCard.value == secondCard.value) {
          firstCard.state = CardState.guessed;
          secondCard.state = CardState.guessed;
          isGameOver = _isGameOver();
          if (!isGameOver) {
            Future.delayed(const Duration(milliseconds: 700), () {
              _visibleCardIndexes.clear();
              _processing = false;
              notifyListeners();
            });
          }
        } else {
          Future.delayed(const Duration(milliseconds: 1500), () {
            for (int index in _visibleCardIndexes) {
              cards[index].state = CardState.hidden;
            }
            _visibleCardIndexes.clear();
            _processing = false;
            notifyListeners();
          });
        }
      } else {
        _processing = false;
        notifyListeners();
      }
    }
  }

  List<CardItem> _createCardItems(
      String imagePath, Color cardColor, int cardValue) {
    return List.generate(
      2,
      (index) => CardItem(
        value: cardValue,
        imagePath: imagePath,
        color: cardColor,
      ),
    );
  }

  bool _isGameOver() {
    return cards.every((card) => card.state == CardState.guessed);
  }
}
