import 'package:flutter/material.dart';
import 'package:roll_over_simon/referee.dart';
import 'package:roll_over_simon/ui_data.dart';

class RefereeBoard extends StatefulWidget {
  const RefereeBoard({super.key, required this.sequence});

  final List<int> sequence;

  @override
  State<RefereeBoard> createState() => _RefereeBoardState();
}

class _RefereeBoardState extends State<RefereeBoard> {
  @override
  void initState() {
    print('call feed');
    Referee().feedRefBoarder();
    super.initState();
  }

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
