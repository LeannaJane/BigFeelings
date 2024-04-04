// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'dart:async';
import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Pages/Minigames%20Page/Memory%20card%20game/Logic/game.dart';
import 'package:big_feelings/Pages/Minigames%20Page/Memory%20card%20game/Logic/confetti.dart';
import 'package:big_feelings/Pages/Minigames%20Page/Memory%20card%20game/Logic/pause_game.dart';
import 'package:big_feelings/Pages/Minigames%20Page/Memory%20card%20game/Logic/restart.dart';
import 'package:big_feelings/Pages/Minigames%20Page/Memory%20card%20game/Logic/time.dart';
import 'package:big_feelings/Pages/Minigames%20Page/Memory%20card%20game/Logic/user_interface_cards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameBoard extends StatefulWidget {
  final Color color;
  const GameBoard({Key? key, required this.color}) : super(key: key);
  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late Timer timer;
  late Game game;
  late Duration duration;
  int bestTime = 0;
  bool showConfetti = false;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    game = Game();
    duration = const Duration();
    startTimer();
    getBestTime();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void getBestTime() async {
    SharedPreferences gameSP = await SharedPreferences.getInstance();
    if (gameSP.getInt('BestTime') != null) {
      setState(() {
        bestTime = gameSP.getInt('BestTime')!;
      });
    }
  }

  Future<void> saveBestTime(int time) async {
    SharedPreferences gameSP = await SharedPreferences.getInstance();
    gameSP.setInt('BestTime', time);
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      if (!isPaused) {
        setState(() {
          final seconds = duration.inSeconds + 1;
          duration = Duration(seconds: seconds);
        });
      }

      if (game.isGameOver) {
        timer.cancel();
        setState(() {
          showConfetti = true;
        });
        if (bestTime == 0 || duration.inSeconds < bestTime) {
          saveBestTime(duration.inSeconds);
          setState(() {
            bestTime = duration.inSeconds;
          });
        }
      }
    });
  }

  void _resetGame() {
    game.resetGame();
    setState(() {
      timer.cancel();
      duration = const Duration();
      startTimer();
    });
  }

  void _pauseGame() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final fontProvider = Provider.of<FontProvider>(context);
      Color iconColor = themeNotifier.getIconColor();
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Match the emotion',
            style: fontProvider.getOtherTitleStyle(themeNotifier),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30.0,
              color: iconColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: 400,
                        height: 850,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 1.0,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            if (index < game.cards.length) {
                              return MemoryCard(
                                isPaused: false,
                                index: index,
                                card: game.cards[index],
                                onCardPressed: game.onCardPressed,
                                frontColor: game.cards[index].color,
                                backColor: widget.color,
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                          itemCount: game.cards.length,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RestartGame(
                          isGameOver: game.isGameOver,
                          restartGame: _resetGame,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 20),
                        GameTimer(
                          time: duration,
                        ),
                        const SizedBox(width: 20),
                        PauseGame(
                          isPaused: isPaused,
                          pauseGame: _pauseGame,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Best Time: $bestTime seconds',
                      style: fontProvider.subheading(themeNotifier),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              if (showConfetti)
                AnimatedOpacity(
                  opacity: showConfetti ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 10000),
                  child: const GameConfetti(),
                ),
            ],
          ),
        ),
      );
    });
  }
}
