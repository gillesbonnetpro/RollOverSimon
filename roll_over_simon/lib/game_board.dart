import 'package:flutter/material.dart';
import 'package:roll_over_simon/notifier.dart';
import 'package:roll_over_simon/player_board.dart';
import 'package:roll_over_simon/referee.dart';
import 'package:roll_over_simon/my_shader.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

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
    double screenwidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double boardSize = MediaQuery.of(context).size.shortestSide * 0.75;
    double headSize = MediaQuery.of(context).size.shortestSide * 0.25;

    return Stack(
      children: [
        Image(
          image: const AssetImage('assets/techno.jpg'),
          height: screenHeight,
          width: screenwidth,
          fit: BoxFit.fil,
        ),
        Center(
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
                          return const FittedBox(
                            child: MyShader(
                              path: 'assets/techno.jpg',
                              child: Text('A vous de jouer'),
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
                          return Container(height: headSize);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: boardSize,
                width: boardSize,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: PlayerBoard(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
