import 'dart:async';

import 'package:flutter/material.dart';
import 'package:roll_over_simon/notifier.dart';
import 'package:roll_over_simon/player_board.dart';
import 'package:roll_over_simon/referee.dart';
import 'dart:ui' as ui;
import 'package:flutter/widgets.dart' as widgets;

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
    double boardSize = MediaQuery.of(context).size.shortestSide * 0.75;
    double headSize = MediaQuery.of(context).size.shortestSide * 0.25;

    Future<ui.Image> loadUiImage(String imageAssetPath) async {
      widgets.Image widgetsImage = widgets.Image.asset(imageAssetPath);
      Completer<ui.Image> completer = Completer<ui.Image>();
      widgetsImage.image
          .resolve(const widgets.ImageConfiguration())
          .addListener(
              widgets.ImageStreamListener((widgets.ImageInfo info, bool _) {
        completer.complete(info.image);
      }));
      return completer.future;
    }

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: headSize,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ValueListenableBuilder<Turn>(
                valueListenable: turnNotifier,
                builder: (BuildContext context, Turn turnValue, child) {
                  switch (turnValue) {
                    case Turn.over:
                      return Center(
                        child: ElevatedButton(
                          onPressed: () => _referee.initGame(),
                          child: const Text('Démarrer'),
                        ),
                      );
                    case Turn.player:
                      return FittedBox(
                        child: FutureBuilder<ui.Image>(
                            future: loadUiImage('assets/soleil.jpg'),
                            builder: (context, snapshot) {
                              return snapshot.hasData
                                  ? ShaderMask(
                                      blendMode: BlendMode.srcATop,
                                      shaderCallback: (bounds) => ImageShader(
                                          snapshot.data!,
                                          TileMode.clamp,
                                          TileMode.clamp,
                                          Matrix4.identity().storage),
                                      child: Text(
                                        'A vous de jouer',
                                        style:
                                            TextStyle().copyWith(fontSize: 50),
                                      ),
                                    )
                                  : Text(
                                      'A vous de jouer',
                                      style: TextStyle().copyWith(fontSize: 50),
                                    );
                            }),
                      );
                    case Turn.rotation:
                      return FittedBox(
                        child: Text(
                          'Changement de niveau',
                          style: TextStyle().copyWith(fontSize: 50),
                        ),
                      );
                    default:
                      return Container(height: headSize);
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: boardSize,
            width: boardSize,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                constraints:
                    BoxConstraints(maxHeight: boardSize, maxWidth: boardSize),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 208, 207, 207),
                ),
                child: const PlayerBoard(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
