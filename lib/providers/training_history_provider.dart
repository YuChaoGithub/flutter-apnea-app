import 'package:flutter/foundation.dart';

import '../models/training_history_data.dart';

class TrainingHistoryProvider with ChangeNotifier {
  List<TrainingHistoryData> _histories = [];

  List<TrainingHistoryData> get histories {
    return [..._histories];
  }
}
