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
    initGame();
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
  late int _pastNb;
  late Turn _turn;
  late List<int> _refSequence;
  late List<int> _plaSequence;
  late List<Pastille> _pastList;
  BehaviorSubject<UiData> uiData_BS = BehaviorSubject();

  // getters
  List<Pastille> get pastList => _pastList;
  List<int> get sequence => _refSequence;
  Stream<UiData> get uiDataStream => uiData_BS.stream;

// --------------------- SECTION REFEREE

  void initGame() {
    _turn = Turn.referee;
    _refSequence = [];
    _plaSequence = [];
    _pastList = [];
    _pastNb = 4;
    addSequence();
  }

  Future<void> addSequence() async {
    if (_refSequence.length < 5 || _pastNb > 9) {
      _refSequence.add(math.Random.secure().nextInt(_pastNb));
      print('ref    $_refSequence');
      Future.delayed(const Duration(seconds: 3), () {
        feedRefBoarder();
      });
    } else {
      _pastNb++;
      _plaSequence.clear();
      _refSequence.clear();
      _refSequence.add(math.Random.secure().nextInt(_pastNb));
      uiData_BS.add(UiData(
          turn: Turn.wait,
          pastList: getPastList(null),
          text: 'Changement de niveau'));
      Future.delayed(const Duration(seconds: 10), () {
        feedRefBoarder();
      });
    }
  }

  Future<void> feedRefBoarder() async {
    int speed = 1000 - (_refSequence.length * _pastNb);
    //print('start feed, seq length ${_refSequence.length}, speed $speed');
    UiData uiData;
    int i = 0;
    while (i < _refSequence.length) {
      //print('$i / ${_refSequence[i]}');
      uiData = UiData(
          turn: _turn,
          sequence: _refSequence,
          pastList: getPastList(_refSequence[i]),
          text: 'Attention !!!');
      uiData_BS.add(uiData);
      await Future.delayed(Duration(milliseconds: speed), () {
        uiData = UiData(
            turn: _turn,
            sequence: _refSequence,
            pastList: getPastList(null),
            text: '');
        uiData_BS.add(uiData);
        i++;
      });
      await Future.delayed(Duration(milliseconds: speed ~/ 2), () {});
    }
    _turn = Turn.player;
    uiData = UiData(
        turn: _turn,
        sequence: null,
        pastList: getPastList(null),
        text: 'A vous de jouer');
    uiData_BS.add(uiData);
    // print('end feed');
  }

// --------------------- SECTION PLAYER

  void playerAttempt(int attempt) {
    if (_refSequence.isNotEmpty) {
      _plaSequence.add(attempt);
      print('player $_plaSequence');

      if (_plaSequence.last != _refSequence[_plaSequence.length - 1]) {
        _turn = Turn.over;
        _refSequence.clear();
        _plaSequence.clear();
        UiData uiData = UiData(
            turn: _turn,
            sequence: null,
            pastList: getPastList(null),
            text: 'PERDU');
        uiData_BS.add(uiData);
      } else {
        // print('bonne réponse');
        if (_plaSequence.length == _refSequence.length) {
          _plaSequence.clear();
          _turn = Turn.referee;
          addSequence();
        }
      }
    }
  }

// --------------------- SECTION COMMON
  List<Pastille> getPastList(int? highlighted) {
    // print('PASlIsT $highlighted');

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
          id: i,
        ),
      );
      angle += portion;
    }
    return _pastList;
  }
}

// gère le tour de jeu
enum Turn { referee, player, over, wait }
