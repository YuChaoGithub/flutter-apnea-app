import 'package:flutter/material.dart';

import './minute_second.dart';

class BreathHoldHistoryData {
  final String key;
  final MinuteSecond holdDuration;
  final MinuteSecond firstContraction;
  final DateTime testDateTime;

  BreathHoldHistoryData({
    @required this.key,
    @required this.holdDuration,
    @required this.firstContraction,
    @required this.testDateTime,
  });
}
