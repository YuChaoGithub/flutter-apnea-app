import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/training_table.dart';
import '../models/minute_second.dart';
import '../widgets/progress_bar.dart';
import '../widgets/timer_view_widget.dart';
import '../widgets/drawer_widget.dart';
import './customize_tables_screen.dart';
import './training_history_screen.dart';
import '../providers/training_table_provider.dart';

class TrainingScreen extends StatefulWidget {
  static const routeName = '/training';

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  static const _timerDelay = Duration(microseconds: 1);

  TrainingTable _currTable;
  Timer _timer;
  Stopwatch _stopwatch = Stopwatch();
  Duration _stopwatchGoal;
  MinuteSecond _timeLeft;
  Function _stopwatchCompletion;

  void _update() {
    if (_stopwatch.isRunning) {
      if (_stopwatch.elapsed > _stopwatchGoal) {
        _stopwatch
          ..stop()
          ..reset();
        _stopwatchCompletion();

        setState(() => _timeLeft = MinuteSecond(minute: 0, second: 0));
      } else {
        setState(() {
          _timeLeft =
              MinuteSecond.fromDuration(_stopwatchGoal - _stopwatch.elapsed);
        });
      }
    }
  }

  void complete() {
    print('COMPLETE!!!');
  }

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(_timerDelay, (Timer t) => _update());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: const Text(
            'Apnea Training',
            textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/icons/settings.png',
                color: Theme.of(context).primaryIconTheme.color),
            onPressed: () {
              Navigator.of(context).pushNamed(CustomizeTableScreen.routeName);
            },
          ),
          IconButton(
            icon: Image.asset('assets/icons/history.png',
                color: Theme.of(context).primaryIconTheme.color),
            onPressed: () {
              Navigator.of(context).pushNamed(TrainingHistoryScreen.routeName);
            },
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Prepare',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Image.asset(
                    'assets/icons/lungs.png',
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: 30),
                Container(
                  width: 70,
                  height: 70,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                ),
                SizedBox(width: 30),
                IconButton(
                  icon: Image.asset(
                    'assets/icons/inspire.png',
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 10),
            TimerViewWidget(_timeLeft),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text('Contraction started at 2:30'),
            ),
            SizedBox(height: 10),
            ProgressBar(),
            SizedBox(height: 20),
            Container(
              height: 70,
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                shape: CircleBorder(
                  side: BorderSide(
                    width: 2,
                    color: Theme.of(context).textTheme.button.color,
                  ),
                ),
                color: Colors.white,
                child: Image.asset(
                  'assets/icons/play.png',
                  scale: 15,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  if (!_stopwatch.isRunning) {
                    _stopwatchGoal = Duration(minutes: 1);
                    _stopwatch.start();
                  }
                },
              ),
            ),
            SizedBox(height: 5),
            Consumer<TrainingTableProvider>(
              builder: (ctx, provider, ch) {
                return DropdownButton(
                  value: _currTable == null ? null : _currTable.key,
                  underline: Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).textTheme.title.color,
                          width: 1.2,
                        ),
                      ),
                    ),
                  ),
                  items: [
                    DropdownMenuItem(
                      value: null,
                      child: const Text('Default Training'),
                    ),
                    ...List<DropdownMenuItem>.generate(
                      provider.tables.length,
                      (i) {
                        final table = provider.tables[i];
                        return DropdownMenuItem(
                          child: Text(table.name),
                          value: table.key,
                        );
                      },
                    ).toList()
                  ],
                  onChanged: (val) {
                    setState(() => _currTable = provider.getTable(val));
                  },
                );
              },
            ),
            SizedBox(height: 20),
            TrainingTableWidget(_currTable),
          ],
        ),
      ),
    );
  }
}

class TrainingTableWidget extends StatelessWidget {
  static const defaultTable = [
    ['1:00', '1:00'],
    ['1:00', '1:00'],
    ['1:00', '1:00'],
  ];

  final TrainingTable _currTable;

  TrainingTableWidget(this._currTable);

  TableRow _buildTableRow(String index, String holdTime, String breatheTime,
      {bool isTitle = false, BuildContext context}) {
    return TableRow(
      decoration: isTitle
          ? BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1,
                      color: Theme.of(context).textTheme.body1.color)))
          : BoxDecoration(),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Text(index,
              textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Text(holdTime,
              textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Text(breatheTime,
              textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        columnWidths: {
          0: FractionColumnWidth(0.15),
        },
        children: <TableRow>[
          _buildTableRow('#', 'Hold', 'Breathe',
              isTitle: true, context: context),
          ...List<TableRow>.generate(
            _currTable == null ? defaultTable.length : _currTable.table.length,
            (i) {
              return _buildTableRow(
                '${i + 1}',
                _currTable == null
                    ? defaultTable[i][0]
                    : _currTable.table[i].holdTime.toString(),
                _currTable == null
                    ? defaultTable[i][1]
                    : _currTable.table[i].breatheTime.toString(),
              );
            },
          ).toList(),
        ],
      ),
    );
  }
}
