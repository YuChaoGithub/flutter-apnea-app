import 'package:flutter/material.dart';

import '../models/minute_second.dart';
import '../db_helper.dart';
import '../models/training_table.dart';

class TrainingTableProvider with ChangeNotifier {
  List<TrainingTable> _tables = [];

  List<TrainingTable> get tables {
    if (_tables.isEmpty) {
      fetchAndSetTable();
    }

    return [..._tables];
  }

  int get tablesLength {
    return _tables.length;
  }

  void addTable(TrainingTable table) {
    if (table.key == '') {
      table.key = UniqueKey().toString();
    }
    _tables.add(table);
    notifyListeners();
    DBHelper.insert('training_table', {
      'uniqueKey': table.key,
      'name': table.name,
      'description': table.description,
    });
    for (int i = 0; i < table.table.length; i++) {
      DBHelper.insert('training_table_entry', {
        'trainingTableKey': table.key,
        'rowIndex': i,
        'holdTime': table.table[i].holdTime.toString(),
        'breatheTime': table.table[i].breatheTime.toString(),
      });
    }
  }

  Future<void> fetchAndSetTable() async {
    _tables = [];
    final tableList = await DBHelper.getData('training_table');
    for (int i = 0; i < tableList.length; i++) {
      TrainingTable currTable = TrainingTable();
      currTable.key = tableList[i]['uniqueKey'];
      currTable.name = tableList[i]['name'];
      currTable.description = tableList[i]['description'];

      final entryList = await DBHelper.getTableEntries(currTable.key);
      for (int row = 0; row < entryList.length; row++) {
        final holdTime = MinuteSecond.fromString(entryList[row]['holdTime']);
        final breatheTime =
            MinuteSecond.fromString(entryList[row]['breatheTime']);
        currTable.table.add(
          TrainingTableEntry(
            index: row,
            holdTime: holdTime,
            breatheTime: breatheTime,
          ),
        );
      }
      _tables.add(currTable);
      _tables.sort((lhs, rhs) => lhs.name.compareTo(rhs.name));
    }
    notifyListeners();
  }

  void deleteTable(String key) async {
    await DBHelper.delete('training_table_entry', 'trainingTableKey', key);
    await DBHelper.delete('training_table', 'uniqueKey', key);
    _tables.removeWhere((table) => table.key == key);
    notifyListeners();
  }

  // void updateTable(String key, TrainingTable table) {
  //   final tableIndex = _tables.indexWhere((t) => t.key == key);
  //   _tables[tableIndex] = table;
  //   notifyListeners();
  // }

  TrainingTable getTable(String key) {
    return _tables.firstWhere((t) => t.key == key, orElse: () => null);
  }
}
