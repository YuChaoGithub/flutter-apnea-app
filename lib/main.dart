import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/training_screen.dart';
import './screens/breath_hold_test_screen.dart';
import './screens/settings_screen.dart';
import './screens/breath_hold_test_history_screen.dart';
import './screens/customize_tables_screen.dart';
import './screens/training_table_detail_screen.dart';
import './screens/training_history_details_screen.dart';
import './screens/training_history_screen.dart';
import './providers/breath_hold_history_provider.dart';
import './providers/training_history_provider.dart';
import './providers/training_table_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: BreathHoldHistoryProvider(),
        ),
        ChangeNotifierProvider.value(
          value: TrainingHistoryProvider(),
        ),
        ChangeNotifierProvider.value(
          value: TrainingTableProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Apnea',
        theme: ThemeData(
          fontFamily: 'Libre Baskerville',
          primaryColor: Colors.white,
          appBarTheme: AppBarTheme(
            color: Colors.white60,
            elevation: 10,
            textTheme: TextTheme().copyWith(
              title: TextStyle(
                color: Theme.of(context).textTheme.button.color,
                fontFamily: 'Exo',
                fontSize: 22,
              ),
            ),
          ),
        ),
        home: TrainingScreen(),
        routes: {
          TrainingScreen.routeName: (ctx) => TrainingScreen(),
          BreathHoldTestScreen.routeName: (ctx) => BreathHoldTestScreen(),
          SettingsScreen.routeName: (ctx) => SettingsScreen(),
          BreathHoldTestHistoryScreen.routeName: (ctx) =>
              BreathHoldTestHistoryScreen(),
          CustomizeTableScreen.routeName: (ctx) => CustomizeTableScreen(),
          TrainingTableDetailScreen.routeName: (ctx) =>
              TrainingTableDetailScreen(),
          TrainingHistoryDetailsScreen.routeName: (ctx) =>
              TrainingHistoryDetailsScreen(),
          TrainingHistoryScreen.routeName: (ctx) => TrainingHistoryScreen(),
        },
      ),
    );
  }
}
