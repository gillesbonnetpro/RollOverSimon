import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roll_over_simon/game_board.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.rubikDistressedTextTheme(),
        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.accent),
      ),
      home: Scaffold(
        body: GameBoard(),
      ),
    );
  }
}
