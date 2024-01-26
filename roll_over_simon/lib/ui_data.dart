import 'dart:convert';
import 'package:roll_over_simon/referee.dart';

class UiData {
  UiData(
      {required this.turn,
      this.sequence,
      required this.pastNb,
      required this.text,
      this.highlighted}) {
    assert(
        (turn == Turn.referee && sequence!.isNotEmpty) || turn != Turn.referee);
  }

  late Turn turn;
  List<int>? sequence;
  late int pastNb;
  late int? highlighted;
  late String text;

  UiData.fromJson(Map<String, dynamic> json) {
    turn = Turn.values.firstWhere((value) => value.toString() == json['turn']);
    sequence = null == json['sequence'] ? null : jsonDecode(json['sequence']);
    pastNb = json[pastNb];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['turn'] = turn.toString();
    data['sequence'] = jsonEncode(sequence);
    data['pastNb'] = pastNb;

    print(data);

    return data;
  }
}
