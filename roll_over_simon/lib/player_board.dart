import 'package:flutter/material.dart';
import 'package:roll_over_simon/referee.dart';
import 'package:roll_over_simon/ui_data.dart';

class PlayerBoard extends StatefulWidget {
  const PlayerBoard({super.key, required this.data});

  final UiData data;

  @override
  State<PlayerBoard> createState() => _PlayerBoardState();
}

class _PlayerBoardState extends State<PlayerBoard> {
  @override
  void initState() {
    /*    if (widget.data.turn == Turn.referee) {
      Referee().feedRefBoarder();
    } */
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
          child: Text(
              widget.data.turn == Turn.referee
                  ? 'Regardez-bien'
                  : widget.data.turn == Turn.player
                      ? 'A vous de jouer'
                      : 'PERDU !!!',
              style: TextStyle(fontSize: 50)),
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
                child: Stack(
                  children: widget.data.pastList,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
