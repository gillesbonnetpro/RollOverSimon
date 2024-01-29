import 'package:flutter/material.dart';
import 'package:roll_over_simon/notifier.dart';
import 'package:roll_over_simon/pastille.dart';
import 'package:roll_over_simon/pastille_old.dart';
import 'dart:math' as math;

class PlayerBoard extends StatefulWidget {
  const PlayerBoard({super.key});

  @override
  State<PlayerBoard> createState() => _PlayerBoardState();
}

class _PlayerBoardState extends State<PlayerBoard> {
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

  double rotationNb = 0;

  @override
  void initState() {
    super.initState();
  }

  List<Pastille> getPastList(int pastNb, Turn turn) {
    List<Pastille> pastList = [];

    pastList.clear();

    for (var i = 0; i < pastNb; i++) {
      pastList.add(Pastille(id: i, color: _colorList[i]));
    }

    /*  if (turn == Turn.player) {
      pastList.shuffle();
      pastList
          .map((past) => Pastille(
              id: past.id, color: past.color, listRank: pastList.indexOf(past)))
          .toList();
    } */
    return pastList;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: pastNumberNotifier,
        builder: (BuildContext context, int pastValue, child) {
          print('rebuild past');
          return ValueListenableBuilder<Turn>(
              valueListenable: turnNotifier,
              builder: (BuildContext context, Turn turnValue, child) {
                List<Pastille> list = getPastList(pastValue, turnValue);
                return AnimatedRotation(
                  duration: const Duration(seconds: 1),
                  turns: turnValue == Turn.rotation ? 1 : 0,
                  child: Stack(
                    children: list,
                  ),
                );
              });
        });
  }
}
