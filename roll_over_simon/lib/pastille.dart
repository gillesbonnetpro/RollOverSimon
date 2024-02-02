import 'package:flutter/material.dart';
import 'package:roll_over_simon/notifier.dart';
import 'dart:math' as math;

import 'package:roll_over_simon/referee.dart';

class Pastille extends StatefulWidget {
  const Pastille(
      {super.key, required this.id, required this.color, this.listRank});

  final int id;
  final MaterialColor color;
  final int? listRank;

  @override
  State<Pastille> createState() => _PastilleState();
}

class _PastilleState extends State<Pastille> {
  late int listRank;
  bool highlight = false;
  double pi2 = math.pi * 2;

  @override
  void initState() {
    listRank = widget.listRank ?? widget.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: pastNumberNotifier,
        builder: (BuildContext context, int pastValue, child) {
          // print('rebuild past');
          double portion = pi2 / pastValue;
          double angle = portion * listRank;
          return ValueListenableBuilder<Turn>(
              valueListenable: turnNotifier,
              builder: (BuildContext context, Turn turnValue, child) {
                // print('rebuild turn');
                return GestureDetector(
                  onTapDown: (details) => setState(() {
                    highlight = true;
                  }),
                  onTapUp: (details) {
                    setState(() {
                      highlight = false;
                    });
                    turnValue == Turn.player
                        ? Referee().playerAttempt(widget.id)
                        : null;
                  },
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 200),
                    alignment: turnValue == Turn.shuffle
                        ? const Alignment(0, 0)
                        : Alignment(
                            (math.cos(angle)) * 0.90, (math.sin(angle)) * 0.90),
                    child: ValueListenableBuilder<int?>(
                        valueListenable: sequenceNotifier,
                        builder: (BuildContext context, int? seqValue, child) {
                          // print('rebuild seq');
                          return Container(
                              height: MediaQuery.of(context).size.shortestSide /
                                  pastValue,
                              width: MediaQuery.of(context).size.shortestSide /
                                  pastValue,
                              decoration: BoxDecoration(
                                color: widget.color,
                                shape: BoxShape.circle,
                                boxShadow: seqValue == widget.id || highlight
                                    ? [
                                        BoxShadow(
                                            color: widget.color.shade100,
                                            offset: const Offset(-1, -1),
                                            blurRadius: 5.0,
                                            spreadRadius: 7.0),
                                        BoxShadow(
                                            color: widget.color.shade800,
                                            offset: const Offset(1, 1),
                                            blurRadius: 5.0,
                                            spreadRadius: 7.0)
                                      ]
                                    : [
                                        const BoxShadow(
                                            color: Color.fromARGB(
                                                255, 104, 103, 103),
                                            offset: Offset(0, 0),
                                            blurRadius: 1.0,
                                            spreadRadius: 5.0),
                                      ],
                              ));
                        }),
                  ),
                );
              });
        });
  }
}
