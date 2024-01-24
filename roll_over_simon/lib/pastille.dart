import 'package:flutter/material.dart';
import 'package:roll_over_simon/referee.dart';

class Pastille extends StatefulWidget {
  Pastille(
      {super.key,
      required this.color,
      required this.posX,
      required this.posY,
      required this.sizeFactor,
      required this.highLight,
      required this.id});
  MaterialColor color;
  double posX;
  double posY;
  int sizeFactor;
  bool highLight;
  int id;

  @override
  State<Pastille> createState() => _PastilleState();
}

class _PastilleState extends State<Pastille> {
  var darkColors = Color(0xFF000A1F);
  var lightColors;

  @override
  void initState() {
    lightColors = widget.color;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Pastille oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.shortestSide / widget.sizeFactor;
    // print('${widget.color} / ${widget.highLight}');

    return GestureDetector(
      onTapDown: (details) => setState(() {
        widget.highLight = true;
        lightColors = widget.color.shade900;
        Referee().playerAttempt(widget.id);
      }),
      onTapUp: (details) => setState(() {
        widget.highLight = false;
        lightColors = widget.color;
      }),
      child: Align(
        alignment: Alignment(widget.posX, widget.posY),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: size,
          height: size,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: widget.highLight ? widget.color.shade400 : widget.color,
            //borderRadius: BorderRadius.circular(20.0),
            shape: BoxShape.circle,
            boxShadow: widget.highLight
                ? [
                    BoxShadow(
                        color: widget.color.shade100,
                        offset: const Offset(-1, -1),
                        blurRadius: 5.0,
                        spreadRadius: 7.0),
                    BoxShadow(
                        color: widget.color.shade800,
                        offset: const Offset(1, 1),
                        blurRadius: 5.0,
                        spreadRadius: 7.0)
                  ]
                : [
                    const BoxShadow(
                        color: Color.fromARGB(255, 208, 207, 207),
                        offset: Offset(-3, -3),
                        blurRadius: 10.0,
                        spreadRadius: 3.0),
                    BoxShadow(
                        color: darkColors,
                        offset: const Offset(3, 3),
                        blurRadius: 10.0,
                        spreadRadius: 3.0)
                  ],
            /*  gradient: LinearGradient(
                begin:
                    widget.highLight ? Alignment.centerLeft : Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.highLight ? lightColors : darkColors,
                  widget.highLight ? darkColors : lightColors
                ]), */
          ),
        ),
      ),
    );
  }
}
