import 'package:flutter/material.dart';
import 'package:roll_over_simon/pastille.dart';
import 'package:roll_over_simon/referee.dart';
import 'package:roll_over_simon/ui_data.dart';
import 'dart:math' as math;

class PlayerBoard extends StatefulWidget {
  const PlayerBoard({super.key, required this.data});

  final UiData data;

  @override
  State<PlayerBoard> createState() => _PlayerBoardState();
}

class _PlayerBoardState extends State<PlayerBoard> {
  late bool rotateWanted;

  final List<MaterialColor> _colorList = [
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

  @override
  void initState() {
    rotateWanted = false;
    print('text ${widget.data.text}');
    super.initState();
  }

  List<Pastille> getPastList(int pastNb, int? highlighted) {
    // print('PASlIsT $highlighted');
    List<Pastille> pastList = [];

    pastList.clear();
    double pi2 = math.pi * 2;
    double portion = pi2 / pastNb;
    double angle = 0;
    for (var i = 0; i < pastNb; i++) {
      double cos = (math.cos(angle)) * 0.90;
      double sin = (math.sin(angle)) * 0.90;
      pastList.add(
        Pastille(
          color: _colorList[i],
          posX: cos,
          posY: sin,
          sizeFactor: pastNb,
          highLight: highlighted == i,
          id: i,
        ),
      );
      angle += portion;
    }
    return pastList;
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.shortestSide * 0.75;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: ElevatedButton(
                child: const Text('RollOver Game'),
                onPressed: () => setState(() {
                  rotateWanted = true;
                  Referee().initGame();
                }),
              ),
            ),
            Flexible(
              child: ElevatedButton(
                child: const Text('Classic Game'),
                onPressed: () => setState(() {
                  rotateWanted = false;
                  Referee().initGame();
                }),
              ),
            )
          ],
        ),
        Center(
          child: Text(
            widget.data.text,
            style: TextStyle(fontSize: 50),
          ),
        ),
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
                child: AnimatedRotation(
                  curve: Curves.bounceOut,
                  duration: const Duration(seconds: 1),
                  turns: widget.data.turn == Turn.player && rotateWanted
                      ? math.Random.secure().nextDouble()
                      : 0,
                  child: Stack(
                    children: getPastList(
                        widget.data.pastNb, widget.data.highlighted),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
