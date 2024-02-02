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
  late bool _shuffleWanted;
  late bool _levelWanted;
  late Widget _divider;

  @override
  void initState() {
    _initialLevel = pastNumberNotifier.value;
    _speed = speedNotifier.value;
    _shuffleWanted = shuffleWantedNotifier.value;
    _levelWanted = levelWantedNotifier.value;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _divider = Divider(thickness: 5, color: Theme.of(context).primaryColor);

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
              _divider,
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
              const Text('Niveau de départ'),
              _divider,
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
              const Text('Vitesse (+ petit = + rapide)'),
              _divider,
              Text('mélange des positions'),
              Switch(
                value: _shuffleWanted,
                onChanged: (value) => setState(() {
                  _shuffleWanted = value;
                  shuffleWantedNotifier.value = value;
                  turnNotifier.value = Turn.start;
                }),
              ),
              _divider,
              Text('changements de niveau'),
              Switch(
                  value: _levelWanted,
                  onChanged: (value) => setState(() {
                        _levelWanted = value;
                        levelWantedNotifier.value = value;
                        turnNotifier.value = Turn.start;
                      }))
            ],
          ),
        ),
      )),
    );
  }
}
