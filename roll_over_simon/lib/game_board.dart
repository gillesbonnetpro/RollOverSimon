import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roll_over_simon/my_shader.dart';
import 'package:roll_over_simon/notifier.dart';
import 'package:roll_over_simon/player_board.dart';
import 'package:roll_over_simon/start_button.dart';
import 'package:roll_over_simon/surounded_text.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double boardSize = MediaQuery.of(context).size.shortestSide * 0.75;
    double headSize = 50;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/starfield.jpg',
            repeat: ImageRepeat.repeat,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: headSize,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ValueListenableBuilder<Turn>(
                          valueListenable: turnNotifier,
                          builder:
                              (BuildContext context, Turn turnValue, child) {
                            switch (turnValue) {
                              case Turn.over:
                                return const Center(
                                  child: StartButton(),
                                );
                              case Turn.start:
                                return const Center(
                                  child: StartButton(),
                                );
                              case Turn.player:
                                return const FittedBox(
                                  child: Text('A vous de jouer'),
                                );
                              case Turn.rotation:
                                return const FittedBox(
                                  child: FittedBox(
                                    child: Text('Changement de niveau'),
                                  ),
                                );
                              default:
                                return Container(height: headSize);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  height: boardSize,
                  width: boardSize,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: PlayerBoard(),
                      ),
                      ValueListenableBuilder<Turn>(
                        valueListenable: turnNotifier,
                        builder: (BuildContext context, Turn turnValue, child) {
                          return turnValue == Turn.over
                              ? FittedBox(
                                  fit: BoxFit.fill,
                                  child: SuroundedText(
                                    text: 'Perdu',
                                    style: GoogleFonts.rubikBubbles(
                                        fontSize: boardSize * 0.8,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                )
                              : Container();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
