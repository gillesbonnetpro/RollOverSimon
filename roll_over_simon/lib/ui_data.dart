import 'dart:convert';

import 'package:roll_over_simon/referee.dart';

class UiData {
  UiData({required this.turn, this.sequence});

  late Turn turn;
  List<int>? sequence;

  UiData.fromJson(Map<String, dynamic> json) {
    turn = Turn.values.firstWhere((value) => value.toString() == json['turn']);
    sequence = null == json['sequence'] ? null : jsonDecode(json['sequence']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['turn'] = turn.toString();
    data['sequence'] = jsonEncode(sequence);

    print(data);

    return data;
  }
}
