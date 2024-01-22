import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:roll_over_simon/pastille.dart';

class GameBoard extends StatefulWidget {
  GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  late List<MaterialColor> colorList;
  late List<Pastille> pastList;
  late int pointNb;

  @override
  void initState() {
    pointNb = 8;

    colorList = [
      Colors.blue,
      Colors.pink,
      Colors.yellow,
      Colors.teal,
      Colors.brown,
      Colors.deepOrange,
      Colors.purple,
      Colors.green,
      Colors.indigo,
      Colors.lightBlue,
    ];

    initPastilles();

    super.initState();
  }

  void initPastilles() {
    pastList = [];
    double pi2 = math.pi * 2;
    double portion = pi2 / pointNb;
    double angle = 0;
    for (var i = 0; i < pointNb; i++) {
      double cos = (math.cos(angle)) * 0.90;
      double sin = (math.sin(angle)) * 0.90;
      pastList.add(
        Pastille(
          color: colorList[i],
          posX: cos,
          posY: sin,
          sizeFactor: pointNb,
          highLight: false,
        ),
      );
      angle += portion;
    }
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
                  children: pastList,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
