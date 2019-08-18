import 'package:apnea/models/minute_second.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../db_helper.dart';
import '../models/breath_hold_history_data.dart';

class BreathHoldHistoryProvider with ChangeNotifier {
  List<BreathHoldHistoryData> _histories = [];

  List<BreathHoldHistoryData> get histories {
    return [..._histories];
  }

  int get historiesLength {
    return _histories.length;
  }

  Future<void> addHistory(BreathHoldHistoryData data) async {
    await DBHelper.insert('breath_hold_histories', {
      'uniqueKey': data.key,
      'datetime': DateFormat('yyyy-MM-dd HH:mm').format(data.testDateTime),
      'firstContraction': data.firstContraction.toString(),
      'duration': data.holdDuration.toString()
    });
  }

  Future<void> fetchAndSetHistory() async {
    List<BreathHoldHistoryData> newHistories = [];
    final historyList = await DBHelper.getData('breath_hold_histories');
    for (int i = 0; i < historyList.length; i++) {
      BreathHoldHistoryData currHistory = BreathHoldHistoryData(
        key: historyList[i]['uniqueKey'],
        testDateTime:
            DateFormat('yyyy-MM-dd HH:mm').parse(historyList[i]['datetime']),
        firstContraction:
            MinuteSecond.fromString(historyList[i]['firstContraction']),
        holdDuration: MinuteSecond.fromString(historyList[i]['duration']),
      );

      newHistories.add(currHistory);
    }
    newHistories
        .sort((lhs, rhs) => lhs.testDateTime.compareTo(rhs.testDateTime));
    _histories = newHistories;
    notifyListeners();
  }

  Future<void> deleteHistory(String key) async {
    await DBHelper.delete('breath_hold_histories', 'uniqueKey', key);
    _histories.removeWhere((history) => history.key == key);
    notifyListeners();
  }

  BreathHoldHistoryData getHistory(String key) {
    return _histories.firstWhere((h) => h.key == key);
  }
}
