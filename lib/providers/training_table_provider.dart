import 'package:flutter/material.dart';

import '../models/minute_second.dart';
import '../db_helper.dart';
import '../models/training_table.dart';

class TrainingTableProvider with ChangeNotifier {
  static final defaultTable = TrainingTable(
    key: '#[00000]',
    name: ' Default Training',
    description: '',
    table: <TrainingTableEntry>[
      TrainingTableEntry(
        index: 0,
        holdTime: MinuteSecond.fromString('1:00'),
        breatheTime: MinuteSecond.fromString('1:00'),
      ),
      TrainingTableEntry(
        index: 1,
        holdTime: MinuteSecond.fromString('1:00'),
        breatheTime: MinuteSecond.fromString('1:00'),
      ),
      TrainingTableEntry(
        index: 2,
        holdTime: MinuteSecond.fromString('1:00'),
        breatheTime: MinuteSecond.fromString('1:00'),
      ),
    ],
  );

  List<TrainingTable> _tables = [defaultTable];

  List<TrainingTable> get tables {
    return [..._tables];
  }

  int get tablesLength {
    return _tables.length;
  }

  Future<void> addTable(TrainingTable table) async {
    await DBHelper.insert('training_table', {
      'uniqueKey': table.key,
      'name': table.name,
      'description': table.description,
    });
    for (int i = 0; i < table.table.length; i++) {
      await DBHelper.insert('training_table_entry', {
        'trainingTableKey': table.key,
        'rowIndex': i,
        'holdTime': table.table[i].holdTime.toString(),
        'breatheTime': table.table[i].breatheTime.toString(),
      });
    }
  }

  Future<void> fetchAndSetTable() async {
    var newTables = [defaultTable];
    final tableList = await DBHelper.getData('training_table');
    for (int i = 0; i < tableList.length; i++) {
      TrainingTable currTable = TrainingTable(
        key: tableList[i]['uniqueKey'],
        name: tableList[i]['name'],
        description: tableList[i]['description'],
        table: [],
      );

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
      newTables.add(currTable);
    }
    newTables.sort((lhs, rhs) => lhs.name.compareTo(rhs.name));
    _tables = newTables;
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
