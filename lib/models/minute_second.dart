import 'package:flutter/foundation.dart';

class MinuteSecond {
  int minute;
  int second;

  MinuteSecond({
    @required this.minute,
    @required this.second,
  });

  MinuteSecond.fromString(String str) {
    if (str == "null") {
      this.minute = -1;
      this.second = -1;
      return;
    }

    final List<String> splitted = str.split(':');
    this.minute = int.parse(splitted[0]);
    this.second = int.parse(splitted[1]);
  }

  MinuteSecond.fromDuration(Duration duration) {
    final seconds = duration.inSeconds;
    this.minute = (seconds / Duration.secondsPerMinute).floor();
    this.second = seconds % Duration.secondsPerMinute;
  }

  Duration toDuration() {
    return Duration(minutes: minute, seconds: second);
  }

  String toString() {
    return '$minute:' + '$second'.padLeft(2, '0');
  }

  bool isNull() {
    return this.minute == -1 && this.second == -1;
  }
}
