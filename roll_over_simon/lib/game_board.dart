import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:roll_over_simon/pastille.dart';
import 'package:roll_over_simon/referee.dart';

class GameBoard extends StatefulWidget {
  GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late Referee _referee;
  late List<Pastille> _pastList;

  @override
  void initState() {
    _referee = Referee();
    _pastList = _referee.getPastList();
    print('$_pastList');

    _referee.addSequence();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.shortestSide * 0.75;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Center(
          child: SizedBox(
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
                child: Stack(
                  children: _pastList,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
