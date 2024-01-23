import 'package:flutter/material.dart';
import 'package:roll_over_simon/pastille.dart';
import 'package:roll_over_simon/referee.dart';
import 'package:roll_over_simon/ui_data.dart';

class PlayerBoard extends StatelessWidget {
  const PlayerBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UiData>(
        stream: Referee().uiDataStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Stack(
                  children: snapshot.data!.pastList,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }
}
