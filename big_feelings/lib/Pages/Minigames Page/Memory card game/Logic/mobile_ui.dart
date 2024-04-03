// ignore_for_file: use_super_parameters, unused_local_variable

import 'dart:async';
import 'package:big_feelings/Pages/Minigames%20Page/Memory%20card%20game/Logic/game.dart';
import 'package:big_feelings/Pages/Minigames%20Page/Memory%20card%20game/Logic/confetti.dart';
import 'package:big_feelings/Pages/Minigames%20Page/Memory%20card%20game/Logic/pause_game.dart';
import 'package:big_feelings/Pages/Minigames%20Page/Memory%20card%20game/Logic/restart.dart';
import 'package:big_feelings/Pages/Minigames%20Page/Memory%20card%20game/Logic/time.dart';
import 'package:big_feelings/Pages/Minigames%20Page/Memory%20card%20game/UI/user_interface_cards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';

class GameBoardMobile extends StatefulWidget {
  final Color color;
  const GameBoardMobile({Key? key, required this.color}) : super(key: key);

  @override
  State<GameBoardMobile> createState() => _GameBoardMobileState();
}

class _GameBoardMobileState extends State<GameBoardMobile> {
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
        SharedPreferences gameSP = await SharedPreferences.getInstance();
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
      double screenWidth = MediaQuery.of(context).size.width;
      double cardSize = screenWidth * 0.2;
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Match the emotion game',
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
          child: Column(
            children: [
              if (showConfetti)
                AnimatedOpacity(
                  opacity: showConfetti ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 1000),
                  child: const GameConfetti(),
                ),
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: 350,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1.0,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 0,
                      ),
                      itemBuilder: (context, index) {
                        if (index < game.cards.length) {
                          return MemoryCard(
                            isPaused: false,
                            index: index,
                            cardSize: cardSize,
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
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 0,
                        bottom: 10,
                      ),
                      child: GameTimer(
                        time: duration,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RestartGame(
                          isGameOver: game.isGameOver,
                          restartGame: _resetGame,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 20),
                        PauseGame(
                          isPaused: isPaused,
                          pauseGame: _pauseGame,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                'Best Time: $bestTime seconds',
                style: fontProvider.subheading(themeNotifier),
              ),
            ],
          ),
        ),
      );
    });
  }
}
