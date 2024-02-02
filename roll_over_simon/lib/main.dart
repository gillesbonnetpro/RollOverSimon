import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roll_over_simon/game_board.dart';
import 'package:roll_over_simon/simon_drawer.dart';

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
        textTheme: GoogleFonts.rubik80sFadeTextTheme()
            .apply(displayColor: Colors.amber, bodyColor: Colors.amber),
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue, accentColor: Colors.amber),
        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.accent),
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text('Roll Over Simon'),
          ),
          body: const GameBoard(),
          drawer: const SimonDrawer(),
        ),
      ),
    );
  }
}
