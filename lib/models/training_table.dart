import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './minute_second.dart';

class TrainingTableEntry {
  final int index;
  final MinuteSecond holdTime;
  final MinuteSecond breatheTime;

  TrainingTableEntry({
    @required this.index,
    @required this.holdTime,
    @required this.breatheTime,
  });
}

class TrainingTable {
  UniqueKey key;
  String name = '';
  String description = '';
  List<TrainingTableEntry> table = [];
}
