import 'package:flutter/material.dart';

class SuroundedText extends StatelessWidget {
  const SuroundedText({super.key, required this.style, required this.text});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Stroked text as border.
        Text(text,
            style: style.copyWith(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 20
                ..color = Colors.black,
            )),
        // Solid text as fill.
        Text(
          text,
          style: style,
        ),
      ],
    );
  }
}
