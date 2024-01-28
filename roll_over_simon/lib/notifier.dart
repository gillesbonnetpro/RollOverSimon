import 'package:flutter/material.dart';

final ValueNotifier<int> pastNumberNotifier = ValueNotifier<int>(4);

final ValueNotifier<int?> sequenceNotifier = ValueNotifier<int?>(null);

final ValueNotifier<Turn> turnNotifier = ValueNotifier<Turn>(Turn.start);

// gère le tour de jeu
enum Turn { referee, player, start, over, wait, shuffle }
