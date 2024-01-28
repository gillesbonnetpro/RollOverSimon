import 'package:flutter/material.dart';
import 'package:roll_over_simon/notifier.dart';
import 'package:roll_over_simon/player_board.dart';
import 'package:roll_over_simon/referee.dart';

import 'package:roll_over_simon/ui_data.dart';

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
    double boardWidth = MediaQuery.of(context).size.shortestSide * 0.75;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () => _referee.morePast(),
                child: Text('pastille'),
              ),
              ElevatedButton(
                onPressed: () => _referee.addSequence(),
                child: Text('sequence'),
              ),
              ElevatedButton(
                onPressed: () => turnNotifier.value == Turn.shuffle
                    ? turnNotifier.value = Turn.over
                    : turnNotifier.value = Turn.shuffle,
                child: Text('shuffle'),
              ),
            ],
          ),
          ValueListenableBuilder<Turn>(
            valueListenable: turnNotifier,
            builder: (BuildContext context, Turn value, child) {
              return Text(
                '$value',
                style: Theme.of(context).textTheme.headline4,
              );
            },
          ),
          SizedBox(
            height: boardWidth,
            width: boardWidth,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                constraints:
                    BoxConstraints(maxHeight: boardWidth, maxWidth: boardWidth),
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
