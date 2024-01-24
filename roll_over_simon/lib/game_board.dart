import 'package:flutter/material.dart';
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
    return StreamBuilder<UiData>(
        stream: _referee.uiDataStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? PlayerBoard(data: snapshot.data!)
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }
}
