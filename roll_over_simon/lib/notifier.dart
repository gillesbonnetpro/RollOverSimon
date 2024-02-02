import 'package:flutter/material.dart';

final ValueNotifier<int> pastNumberNotifier = ValueNotifier<int>(4);

final ValueNotifier<int?> sequenceNotifier = ValueNotifier<int?>(null);

final ValueNotifier<Turn> turnNotifier = ValueNotifier<Turn>(Turn.start);

final ValueNotifier<int> speedNotifier = ValueNotifier<int>(500);

final ValueNotifier<bool> shuffleWantedNotifier = ValueNotifier<bool>(true);

final ValueNotifier<bool> levelWantedNotifier = ValueNotifier<bool>(true);

// gère le tour de jeu
enum Turn { referee, player, start, over, wait, shuffle, rotation }
