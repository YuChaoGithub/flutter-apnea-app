import 'package:flutter/material.dart';

import './training_table.dart';
import './minute_second.dart';

class TrainingHistoryData {
  final String key;
  final DateTime trainingDateTime;
  final String name;
  final String description;
  final List<TrainingTableEntry> table;
  final List<MinuteSecond> contractions;

  TrainingHistoryData({
    @required this.key,
    @required this.table,
    @required this.contractions,
    @required this.trainingDateTime,
    @required this.description,
    @required this.name,
  });
}
