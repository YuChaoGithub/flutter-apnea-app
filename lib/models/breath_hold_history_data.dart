import 'package:flutter/material.dart';

import './minute_second.dart';

class BreathHoldHistoryData {
  final UniqueKey key;
  final MinuteSecond holdDuration;
  final MinuteSecond firstContraction;
  final DateTime testDateTime;
  final String description;

  BreathHoldHistoryData({
    @required this.key,
    @required this.holdDuration,
    @required this.firstContraction,
    @required this.testDateTime,
    @required this.description,
  });
}
