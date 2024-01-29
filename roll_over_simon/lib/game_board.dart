import 'package:flutter/material.dart';
import 'package:roll_over_simon/notifier.dart';
import 'package:roll_over_simon/player_board.dart';
import 'package:roll_over_simon/referee.dart';
import 'package:google_fonts/google_fonts.dart';

class GameBoard extends StatefulWidget {
  GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late Referee _referee;

  @override
  void initState() {
    _referee = Referee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double boardSize = MediaQuery.of(context).size.shortestSide * 0.75;
    double headSize = MediaQuery.of(context).size.shortestSide * 0.25;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: headSize,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ValueListenableBuilder<Turn>(
                valueListenable: turnNotifier,
                builder: (BuildContext context, Turn turnValue, child) {
                  switch (turnValue) {
                    case Turn.over:
                      return Center(
                        child: ElevatedButton(
                          onPressed: () => _referee.initGame(),
                          child: const Text('Démarrer'),
                        ),
                      );
                    case Turn.player:
                      return FittedBox(
                        child: Text(
                          'A vous de jouer',
                          style: TextStyle().copyWith(fontSize: 50),
                        ),
                      );
                    case Turn.rotation:
                      return FittedBox(
                        child: Text(
                          'Changement de niveau',
                          style: TextStyle().copyWith(fontSize: 50),
                        ),
                      );
                    default:
                      return Container();
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: boardSize,
            width: boardSize,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                constraints:
                    BoxConstraints(maxHeight: boardSize, maxWidth: boardSize),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 208, 207, 207),
                ),
                child: const PlayerBoard(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
