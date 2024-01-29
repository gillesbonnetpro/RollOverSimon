import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roll_over_simon/referee.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => Referee().initGame(),
        child: Text(
          'Démarrer',
          style: GoogleFonts.aBeeZee(),
        ));
  }
}
