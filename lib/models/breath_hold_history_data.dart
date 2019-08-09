import 'package:flutter/foundation.dart';

import './minute_second.dart';

class BreathHoldHistory {
  final MinuteSecond holdDuration;
  final MinuteSecond firstContraction;
  final DateTime testDateTime;
  final String description;

  BreathHoldHistory({
    @required this.holdDuration,
    @required this.firstContraction,
    @required this.testDateTime,
    @required this.description,
  });
}
