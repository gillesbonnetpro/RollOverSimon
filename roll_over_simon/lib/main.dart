import 'package:flutter/material.dart';
import 'package:roll_over_simon/game_board.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GameBoard(),
      ),
    );
  }
}
