import 'package:flutter/material.dart';
import 'package:roll_over_simon/pastille.dart';
import 'dart:math' as math;
import 'package:rxdart/rxdart.dart';

class Referee {
  static final Referee _singleton = Referee._internal();

  factory Referee() {
    return _singleton;
  }

  Referee._internal();

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

  final int _pastNb = 4;
  Turn _turn = Turn.referee;
  final List<int> _refSequence = [];
  final List<Pastille> _pastList = [];
  List<Pastille> get pastList => _pastList;
  List<int> get sequence => _refSequence;
  Turn get turn => _turn;

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

  List<Pastille> getPastList() {
    print('PALSIT');
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
          highLight: false,
        ),
      );
      angle += portion;
    }
    return _pastList;
  }
}

// gère le tour de jeu
enum Turn { referee, player }
