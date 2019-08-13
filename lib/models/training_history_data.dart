import 'package:flutter/material.dart';

import './training_table.dart';
import './minute_second.dart';

class TrainingHistoryData {
  final String key;
  final TrainingTable table;
  final MinuteSecond firstContraction;
  final DateTime trainingDateTime;
  final String description;

  TrainingHistoryData({
    @required this.key,
    @required this.table,
    @required this.firstContraction,
    @required this.trainingDateTime,
    @required this.description,
  });
}
