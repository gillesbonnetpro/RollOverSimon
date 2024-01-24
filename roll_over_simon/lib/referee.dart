import 'dart:async';

import 'package:flutter/material.dart';
import 'package:roll_over_simon/pastille.dart';
import 'package:roll_over_simon/ui_data.dart';
import 'dart:math' as math;
import 'package:rxdart/rxdart.dart';

class Referee {
  static final Referee _singleton = Referee._internal();

  factory Referee() {
    return _singleton;
  }

  Referee._internal() {
    _refSequence = [0, 1, 2, 3, 0, 1, 2, 3];
    _initGame();
  }

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

  // variables
  final int _pastNb = 4;
  Turn _turn = Turn.referee;
  List<int> _refSequence = [];
  final List<Pastille> _pastList = [];
  BehaviorSubject<UiData> uiData_BS = BehaviorSubject();

  // getters
  List<Pastille> get pastList => _pastList;
  List<int> get sequence => _refSequence;
  Turn get turn => _turn;
  Stream<UiData> get uiDataStream => uiData_BS.stream;

  void _initGame() {
// set data
    print('start init');
    UiData _uiData = UiData(
      turn: Turn.referee,
      sequence: _refSequence,
      pastList: getPastList(null),
    );
    uiData_BS.add(_uiData);
    print('end init');
  }

  void addSequence() {
    while (_refSequence.length < 10) {
      print('Dans addSeq');
      Future.delayed(const Duration(seconds: 5)).then((value) {
        _refSequence.add(math.Random.secure().nextInt(_pastNb));
        print('SEQUENCE ${_refSequence.length} : $_refSequence');
        for (int nb in _refSequence) {
          Pastille p = _pastList[nb];
          _pastList[nb] = Pastille(
              color: p.color,
              posX: p.posX,
              posY: p.posY,
              sizeFactor: p.sizeFactor,
              highLight: true);
        }
      });
    }
  }

  List<Pastille> getPastList(int? highlighted) {
    print('PASlIsT $highlighted');

    _pastList.clear();
    double pi2 = math.pi * 2;
    double portion = pi2 / _pastNb;
    double angle = 0;
    for (var i = 0; i < _pastNb; i++) {
      double cos = (math.cos(angle)) * 0.90;
      double sin = (math.sin(angle)) * 0.90;
      _pastList.add(
        Pastille(
          color: _colorList[i],
          posX: cos,
          posY: sin,
          sizeFactor: _pastNb,
          highLight: highlighted == i,
        ),
      );
      angle += portion;
    }
    return _pastList;
  }

  Future<void> feedRefBoarder() async {
    print('start feed');
    UiData _uiData;
    int i = 0;
    while (i < _refSequence.length) {
      await Future.delayed(const Duration(seconds: 2), () {
        print('$i / ${_refSequence[i]}');
        _uiData = UiData(
          turn: Turn.referee,
          sequence: _refSequence,
          pastList: getPastList(_refSequence[i]),
        );
        uiData_BS.add(_uiData);
        i++;
      });
    }
    _uiData = UiData(
      turn: Turn.player,
      sequence: null,
      pastList: getPastList(null),
    );
    uiData_BS.add(_uiData);
    print('end feed');
  }

  /* for (var number in _refSequence) {
      print('appel $number');
      Future.delayed(const Duration(seconds: 2), () {
        _uiData = UiData(
          turn: Turn.player,
          sequence: _refSequence,
          pastList: getPastList(number),
        );
        print('envoi $number dans le stream');
        uiData_BS.add(_uiData);
      });
    } */
}

// gère le tour de jeu
enum Turn { referee, player }
