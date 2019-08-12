import 'package:flutter/material.dart';

import '../models/training_table.dart';

class TrainingTableProvider with ChangeNotifier {
  List<TrainingTable> _tables = [];

  List<TrainingTable> get tables {
    return [..._tables];
  }

  int get tablesLength {
    return _tables.length;
  }

  void addTable(TrainingTable table) {
    table.key = UniqueKey();
    _tables.add(table);
    print(table.table[0].breatheTime);
    notifyListeners();
  }

  void deleteTable(UniqueKey key) {
    _tables.removeWhere((table) => table.key == key);
    notifyListeners();
  }

  void updateTable(UniqueKey key, TrainingTable table) {
    final tableIndex = _tables.indexWhere((t) => t.key == key);
    _tables[tableIndex] = table;
    notifyListeners();
  }

  TrainingTable getTable(UniqueKey key) {
    return _tables.firstWhere((t) => t.key == key);
  }
}
