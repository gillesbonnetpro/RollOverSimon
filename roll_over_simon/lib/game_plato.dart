import 'package:flutter/material.dart';
import 'package:roll_over_simon/my_shader.dart';

class GamePlato extends StatelessWidget {
  const GamePlato({super.key});

  @override
  Widget build(BuildContext context) {
    return MyShader(
      path: 'assets/techno.jpg',
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(255, 208, 207, 207),
        ),
      ),
    );
  }
}
