import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../db_helper.dart';
import '../models/training_history_data.dart';
import '../models/minute_second.dart';
import '../models/training_table.dart';

class TrainingHistoryProvider with ChangeNotifier {
  List<TrainingHistoryData> _histories = [];

  List<TrainingHistoryData> get histories {
    return [..._histories];
  }

  int get historiesLength {
    return _histories.length;
  }

  Future<void> addHistory(TrainingHistoryData history) async {
    await DBHelper.insert('training_histories', {
      'uniqueKey': history.key,
      'name': history.name,
      'description': history.description,
      'datetime':
          DateFormat('yyyy-MM-dd HH:mm').format(history.trainingDateTime),
    });

    for (int i = 0; i < history.contractions.length; i++) {
      await DBHelper.insert('contractions', {
        'trainingHistoryKey': history.key,
        'rowIndex': i,
        'time': history.contractions[i].toString(),
      });
    }

    for (int i = 0; i < history.table.length; i++) {
      await DBHelper.insert('training_table_entry', {
        'trainingTableKey': history.key,
        'rowIndex': i,
        'holdTime': history.table[i].holdTime.toString(),
        'breatheTime': history.table[i].breatheTime.toString(),
      });
    }
  }

  Future<void> fetchAndSetHistories() async {
    var newHistories = <TrainingHistoryData>[];
    final historyList = await DBHelper.getData('training_histories');
    for (int i = 0; i < historyList.length; i++) {
      var currHistory = TrainingHistoryData(
        key: historyList[i]['uniqueKey'],
        name: historyList[i]['name'],
        description: historyList[i]['description'],
        trainingDateTime:
            DateFormat('yyyy-MM-dd HH:mm').parse(historyList[i]['datetime']),
        table: [],
        contractions: [],
      );

      final entryList = await DBHelper.getTableEntries(currHistory.key);
      for (int row = 0; row < entryList.length; row++) {
        final holdTime = MinuteSecond.fromString(entryList[row]['holdTime']);
        final breatheTime =
            MinuteSecond.fromString(entryList[row]['breatheTime']);
        currHistory.table.add(TrainingTableEntry(
          index: row,
          holdTime: holdTime,
          breatheTime: breatheTime,
        ));
      }

      final contractionList = await DBHelper.getContractions(currHistory.key);
      for (int row = 0; row < contractionList.length; row++) {
        currHistory.contractions
            .add(MinuteSecond.fromString(contractionList[row]));
      }
      newHistories.add(currHistory);
    }
    newHistories.sort(
        (lhs, rhs) => lhs.trainingDateTime.compareTo(rhs.trainingDateTime));
    _histories = newHistories;
  }

  void deleteHistory(String key) async {
    await DBHelper.delete('training_table_entry', 'trainingTableKey', key);
    await DBHelper.delete('history_table', 'uniqueKey', key);
    _histories.removeWhere((history) => history.key == key);
    notifyListeners();
  }

  TrainingHistoryData getHistory(String key) {
    return _histories.firstWhere((h) => h.key == key, orElse: () => null);
  }
}
