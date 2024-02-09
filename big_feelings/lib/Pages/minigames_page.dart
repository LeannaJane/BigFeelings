// Rename the file to minigames_page.dart
import 'package:flutter/material.dart';

class MiniGamesPage extends StatelessWidget {
  const MiniGamesPage({super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minigame page'),
      ),
    );
  }
}
