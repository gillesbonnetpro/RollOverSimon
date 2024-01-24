import 'package:flutter/material.dart';
import 'package:roll_over_simon/referee.dart';
import 'package:roll_over_simon/ui_data.dart';

class PlayerBoard extends StatefulWidget {
  PlayerBoard({super.key, required this.data});

  final UiData data;

  @override
  State<PlayerBoard> createState() => _PlayerBoardState();
}

class _PlayerBoardState extends State<PlayerBoard> {
  @override
  void initState() {
    if (widget.data.turn == Turn.referee) {
      Referee().feedRefBoarder();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UiData>(
        stream: Referee().uiDataStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Column(
                  children: [
                    Text('${widget.data.turn}'),
                    Expanded(
                      child: Stack(
                        children: snapshot.data!.pastList,
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }
}
