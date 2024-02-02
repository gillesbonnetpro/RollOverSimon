import 'dart:async';
import 'package:roll_over_simon/notifier.dart';
import 'dart:math' as math;

class Referee {
  static final Referee _singleton = Referee._internal();

  factory Referee() {
    return _singleton;
  }

  Referee._internal() {
    // initGame();
  }

  // variables
  late int _pastNb;
  late Turn _turn;
  late List<int> _refSequence;
  late List<int> _plaSequence;

  // getters
  List<int> get sequence => _refSequence;

// --------------------- SECTION REFEREE

  void initGame() {
    print('INIT');
    _turn = Turn.referee;
    _pastNb = pastNumberNotifier.value;
    turnNotifier.value = _turn;
    _refSequence = [];
    _plaSequence = [];

    pastNumberNotifier.value = _pastNb;

    addSequence();
  }

  Future<void> addSequence() async {
    if (_refSequence.length > _pastNb && _pastNb < 10) {
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

    /*  // empeche d'avoir 3 fois le meme numéro de suite
    int next = 0;
    bool isRepeted = true;
    while (isRepeted) {
      next = math.Random.secure().nextInt(_pastNb);
      int length = _refSequence.length;
      print('nb element ${_refSequence.length}');
      if (length > 2) {
        print('element -1  ${_refSequence[length - 1]}');
        print('element -2  ${_refSequence[length - 2]}');
      }

      if (length > 2 &&
          (_refSequence[length - 1] == _refSequence[length - 2])) {
        if (next != _refSequence[length]) {
          isRepeted = false;
        }
      } else {
        isRepeted = false;
      }
      print('repeted $isRepeted'); 
    }*/
    _refSequence.add(math.Random.secure().nextInt(_pastNb));
    sendSeq();
  }

  Future<void> sendSeq() async {
    int speed = speedNotifier.value - (_refSequence.length * _pastNb);
    if (_refSequence.length == 1) {
      await Future.delayed(const Duration(seconds: 1));
    }
    for (int i in _refSequence) {
      await Future.delayed(
          Duration(milliseconds: speed), () => sequenceNotifier.value = i);
      await Future.delayed(Duration(milliseconds: speed ~/ 2),
          () => sequenceNotifier.value = null);
    }
    print('ref    $_refSequence');
    await Future.delayed(Duration(seconds: 1));
    turnNotifier.value = Turn.shuffle;
    await Future.delayed(Duration(seconds: 1));
    turnNotifier.value = Turn.player;
    /* await Future.delayed(
        -const Duration(seconds: 2), () => turnNotifier.value = Turn.shuffle);
    turnNotifier.value = Turn.player;
     */ /* await Future.delayed(
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
        print('referee : perdu');
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
