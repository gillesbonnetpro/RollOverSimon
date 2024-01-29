import 'dart:async';

import 'package:flutter/material.dart';
import 'package:roll_over_simon/notifier.dart';
import 'package:roll_over_simon/pastille_old.dart';
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

  // getters
  List<int> get sequence => _refSequence;

// --------------------- SECTION REFEREE

  void initGame() {
    _turn = Turn.referee;
    _refSequence = [];
    _plaSequence = [];

    _pastNb = 4;
    pastNumberNotifier.value = _pastNb;

    addSequence();
  }

  Future<void> addSequence() async {
    if (_refSequence.length > 2 && _pastNb < 9) {
      print('LEVEL !!! ');
      turnNotifier.value = Turn.rotation;
      await Future.delayed(const Duration(seconds: 1), () {
        _pastNb++;
        pastNumberNotifier.value = (_pastNb);
        _plaSequence.clear();
        _refSequence.clear();
        turnNotifier.value = Turn.referee;
      });
    }
    _refSequence.add(math.Random.secure().nextInt(_pastNb));
    sendSeq();
  }

  Future<void> sendSeq() async {
    int speed = 500 - (_refSequence.length * _pastNb);
    if (_refSequence.length == 1) {
      await Future.delayed(const Duration(seconds: 1), () {});
    }
    for (int i in _refSequence) {
      await Future.delayed(
          Duration(milliseconds: speed), () => sequenceNotifier.value = i);
      await Future.delayed(Duration(milliseconds: speed ~/ 2),
          () => sequenceNotifier.value = null);
    }
    print('ref    $_refSequence');
    await Future.delayed(
        -const Duration(seconds: 2), () => turnNotifier.value = Turn.shuffle);
    turnNotifier.value = Turn.player;
    /* await Future.delayed(
        const Duration(seconds: 2), () => turnNotifier.value = Turn.player); */
  }

// --------------------- SECTION PLAYER

  Future<void> playerAttempt(int attempt) async {
    if (_refSequence.isNotEmpty) {
      print('player clicked $attempt');
      _plaSequence.add(attempt);
      print('player $_plaSequence');

      if (_plaSequence.last != _refSequence[_plaSequence.length - 1]) {
        turnNotifier.value = Turn.over;
        _refSequence.clear();
        _plaSequence.clear();
      } else {
        // print('bonne réponse');
        if (_plaSequence.length == _refSequence.length) {
          _plaSequence.clear();
          turnNotifier.value = Turn.referee;
          await Future.delayed(const Duration(seconds: 1), () => addSequence());
        }
      }
    }
  }

// --------------------- SECTION COMMON
  void morePast() {
    _pastNb++;
    pastNumberNotifier.value = _pastNb;
  }

  void rotate() {}
}
