import 'package:flutter/foundation.dart';

import '../models/breath_hold_history_data.dart';

class BreathHoldHistoryProvider with ChangeNotifier {
  List<BreathHoldHistoryData> _histories = [];

  List<BreathHoldHistoryData> get histories {
    return [..._histories];
  }
}
