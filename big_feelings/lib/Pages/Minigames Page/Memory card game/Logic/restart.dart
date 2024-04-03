// restart_game.dart
// ignore_for_file: use_super_parameters

import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestartGame extends StatelessWidget {
  final bool isGameOver;
  final void Function() restartGame;
  final Color color;

  const RestartGame({
    required this.isGameOver,
    required this.restartGame,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final fontProvider = Provider.of<FontProvider>(context);
      Color getContainerColor =
          Provider.of<ThemeNotifier>(context).getContainerColor();
      return GestureDetector(
        onTap: restartGame,
        child: Container(
          width: 150,
          height: 40,
          decoration: BoxDecoration(
            color: getContainerColor,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Reset game',
              style: fontProvider.subheading(themeNotifier),
            ),
          ),
        ),
      );
    });
  }
}
