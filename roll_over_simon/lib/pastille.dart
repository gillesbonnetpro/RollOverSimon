import 'package:flutter/material.dart';
import 'package:roll_over_simon/notifier.dart';
import 'dart:math' as math;

import 'package:roll_over_simon/referee.dart';

class Pastille extends StatefulWidget {
  const Pastille({super.key, required this.id, required this.color});
  final int id;
  final MaterialColor color;

  @override
  State<Pastille> createState() => _PastilleState();
}

class _PastilleState extends State<Pastille> {
  late double id;
  bool highlight = false;
  double pi2 = math.pi * 2;

  @override
  void initState() {
    id = widget.id / 10;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => setState(() {
        highlight = true;
      }),
      onTapUp: (details) {
        setState(() {
          highlight = false;
        });
        Referee().playerAttempt(widget.id);
      },
      child: ValueListenableBuilder<int>(
          valueListenable: pastNumberNotifier,
          builder: (BuildContext context, int pastValue, child) {
            // print('rebuild past');
            double portion = pi2 / pastValue;
            double angle = portion * widget.id;
            return ValueListenableBuilder<Turn>(
                valueListenable: turnNotifier,
                builder: (BuildContext context, Turn turnValue, child) {
                  // print('rebuild turn');
                  return AnimatedAlign(
                    duration: const Duration(seconds: 1),
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
                                                255, 208, 207, 207),
                                            offset: Offset(-3, -3),
                                            blurRadius: 10.0,
                                            spreadRadius: 3.0),
                                        const BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(3, 3),
                                            blurRadius: 10.0,
                                            spreadRadius: 3.0)
                                      ],
                              ));
                        }),
                  );
                });
          }),
    );
  }
}
