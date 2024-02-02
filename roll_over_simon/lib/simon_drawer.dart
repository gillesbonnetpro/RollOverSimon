import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:roll_over_simon/notifier.dart';

class SimonDrawer extends StatefulWidget {
  const SimonDrawer({super.key});

  @override
  State<SimonDrawer> createState() => _SimonDrawerState();
}

class _SimonDrawerState extends State<SimonDrawer> {
  late int _initialLevel;
  late int _speed;

  @override
  void initState() {
    _initialLevel = pastNumberNotifier.value;
    _speed = speedNotifier.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textTheme: GoogleFonts.aBeeZeeTextTheme(),
      ),
      child: Drawer(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).primaryColor.withOpacity(0.5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const FittedBox(
                child: Text('Paramètres'),
              ),
              NumberPicker(
                itemWidth: 50,
                axis: Axis.horizontal,
                value: _initialLevel,
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).focusColor)),
                minValue: 4,
                maxValue: 10,
                onChanged: (value) => setState(() {
                  _initialLevel = value;
                  pastNumberNotifier.value = _initialLevel;
                  turnNotifier.value = Turn.start;
                }),
              ),
              Text('Niveau de départ'),
              Divider(thickness: 5, color: Theme.of(context).primaryColor),
              NumberPicker(
                itemWidth: 55,
                axis: Axis.horizontal,
                value: _speed,
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).focusColor)),
                minValue: 50,
                maxValue: 950,
                step: 50,
                onChanged: (value) => setState(() {
                  _speed = value;
                  speedNotifier.value = _speed;
                  turnNotifier.value = Turn.start;
                }),
              ),
              Text('Vitesse (+ petit = + rapide)'),
              Divider(thickness: 5, color: Theme.of(context).primaryColor),
            ],
          ),
        ),
      )),
    );
  }
}
