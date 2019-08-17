import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/training_table.dart';
import '../models/minute_second.dart';
import '../models/training_history_data.dart';
import '../widgets/progress_bar.dart';
import '../widgets/timer_view_widget.dart';
import '../widgets/drawer_widget.dart';
import './customize_tables_screen.dart';
import './training_history_screen.dart';
import '../providers/training_table_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/training_history_provider.dart';

class TrainingScreen extends StatefulWidget {
  static const routeName = '/training';

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  static const _timerDelay = Duration(microseconds: 1);
  TrainingTable _currTable = TrainingTableProvider.defaultTable;
  int _currRow = -1;
  int _currCol = 1;
  Timer _timer;
  Stopwatch _stopwatch = Stopwatch();
  Duration _stopwatchGoal;
  MinuteSecond _timeLeft;
  Future<void> fetchFuture;
  bool _paused = false;
  MinuteSecond _contractionTime;
  List<MinuteSecond> _allContractionTimes;

  void _startTimer() {
    _currRow = -1;
    _currCol = 1;
    _allContractionTimes = [];
    _stopwatchGoal = SettingsProvider.prepareTime;
    _stopwatch.start();
  }

  void _pauseTimer() {
    _paused = true;
    _stopwatch.stop();
  }

  void _resumeTimer() {
    _paused = false;
    _stopwatch.start();
  }

  void _configureStopwatchAndStart() {
    final MinuteSecond goal = _currCol == 0
        ? _currTable.table[_currRow].holdTime
        : _currTable.table[_currRow].breatheTime;
    _stopwatchGoal = Duration(minutes: goal.minute, seconds: goal.second);
    _stopwatch.start();
  }

  void _recordContractionTime() {
    _contractionTime =
        MinuteSecond.fromDuration(_stopwatchGoal - _timeLeft.toDuration());
    _allContractionTimes.add(_contractionTime);
  }

  void _stopwatchCompleted() {
    if (_currCol == 0) {
      setState(() {
        ++_currCol;
        _contractionTime = null;
        _configureStopwatchAndStart();
      });
    } else if (_currRow + 1 < _currTable.table.length) {
      setState(() {
        _currCol = 0;
        ++_currRow;
        _configureStopwatchAndStart();
      });
    } else {
      _terminateSession();
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text(
              'Good Job!',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            content: const Text('The session has completed!'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'OK!',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.button.color,
                  ),
                ),
                onPressed: () {
                  final history = TrainingHistoryData(
                    key: UniqueKey().toString(),
                    name: _currTable.name,
                    description: _currTable.description,
                    table: _currTable.table,
                    trainingDateTime: DateTime.now(),
                    contractions: _allContractionTimes,
                  );
                  Provider.of<TrainingHistoryProvider>(context, listen: false)
                      .addHistory(history)
                      .then((_) => Navigator.of(context).pop());
                },
              )
            ],
          );
        },
      );
    }
  }

  void _terminateSession() {
    _stopwatch
      ..stop()
      ..reset();
    setState(() {
      _timeLeft = null;
      _currRow = -1;
      _contractionTime = null;
    });
  }

  void _update() {
    if (_stopwatch.isRunning) {
      if (_stopwatch.elapsed > _stopwatchGoal) {
        _stopwatch
          ..stop()
          ..reset();

        setState(() => _timeLeft = MinuteSecond(minute: 0, second: 0));
        _stopwatchCompleted();
      } else {
        setState(() {
          _timeLeft =
              MinuteSecond.fromDuration(_stopwatchGoal - _stopwatch.elapsed);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    fetchFuture = Provider.of<TrainingTableProvider>(context, listen: false)
        .fetchAndSetTable();
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
        actions: (_paused || _stopwatch.isRunning)
            ? []
            : <Widget>[
                IconButton(
                  icon: Image.asset('assets/icons/settings.png',
                      color: Theme.of(context).primaryIconTheme.color),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(CustomizeTableScreen.routeName);
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/icons/history.png',
                      color: Theme.of(context).primaryIconTheme.color),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(TrainingHistoryScreen.routeName);
                  },
                ),
              ],
      ),
      drawer: (_paused || _stopwatch.isRunning) ? null : DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              _paused
                  ? 'Paused'
                  : (_currRow < 0
                      ? 'Prepare'
                      : (_currCol == 0 ? 'Hold' : 'Breathe')),
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
                  onPressed: !_paused &&
                          (_contractionTime == null) &&
                          _currRow >= 0 &&
                          _currCol == 0
                      ? () {
                          if (_stopwatch.isRunning) {
                            _recordContractionTime();
                          }
                        }
                      : null,
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
              child: _contractionTime == null
                  ? Container()
                  : Text(
                      'Contraction started at ${_contractionTime.toString()}.'),
            ),
            SizedBox(height: 10),
            _timeLeft == null
                ? ProgressBar(1.0)
                : ProgressBar(_timeLeft.toDuration().inMilliseconds /
                    _stopwatchGoal.inMilliseconds),
            SizedBox(height: 20),
            _stopwatch.isRunning
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ControlButton(
                          'assets/icons/pause.png', () => _pauseTimer()),
                      ControlButton(
                          'assets/icons/stop.png', () => _terminateSession()),
                    ],
                  )
                : ControlButton('assets/icons/play.png', () {
                    if (_paused) {
                      _resumeTimer();
                    } else {
                      _startTimer();
                    }
                  }),
            FutureBuilder(
              future: fetchFuture,
              builder: (ctx, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Center(child: CircularProgressIndicator())
                      : Consumer<TrainingTableProvider>(
                          builder: (ctx, provider, ch) {
                            _currTable = provider.getTable(_currTable.key);
                            return (_paused || _stopwatch.isRunning)
                                ? SizedBox(height: 15)
                                : DropdownButton(
                                    value: _currTable.key,
                                    underline: Container(
                                      height: 1.0,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Theme.of(context)
                                                .textTheme
                                                .title
                                                .color,
                                            width: 1.2,
                                          ),
                                        ),
                                      ),
                                    ),
                                    items: List<DropdownMenuItem>.generate(
                                      provider.tables.length,
                                      (i) {
                                        final table = provider.tables[i];
                                        return DropdownMenuItem(
                                          child: Text(table.name),
                                          value: table.key,
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (val) {
                                      setState(() =>
                                          _currTable = provider.getTable(val));
                                    },
                                  );
                          },
                        ),
            ),
            SizedBox(height: 20),
            TrainingTableWidget(_currTable, _currRow, _currCol),
          ],
        ),
      ),
    );
  }
}

class ControlButton extends StatelessWidget {
  ControlButton(this._iconPath, this._onPressed);

  final Function _onPressed;
  final String _iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          _iconPath,
          scale: 15,
          color: Theme.of(context).iconTheme.color,
        ),
        onPressed: _onPressed,
      ),
    );
  }
}

class TrainingTableWidget extends StatelessWidget {
  final TrainingTable _currTable;
  final int _currRow;
  final int _currCol;

  TrainingTableWidget(this._currTable, this._currRow, this._currCol);

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
          child: Text(
            index,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Text(
            holdTime,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: (!isTitle &&
                      _currRow >= 0 &&
                      _currRow == int.parse(index) - 1 &&
                      _currCol == 0)
                  ? Colors.lightBlue
                  : Theme.of(context).textTheme.title.color,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Text(
            breatheTime,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: (!isTitle &&
                      _currRow >= 0 &&
                      _currRow == int.parse(index) - 1 &&
                      _currCol == 1)
                  ? Colors.lightBlue
                  : Theme.of(context).textTheme.title.color,
            ),
          ),
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
            _currTable.table.length,
            (i) {
              return _buildTableRow(
                '${i + 1}',
                _currTable.table[i].holdTime.toString(),
                _currTable.table[i].breatheTime.toString(),
                context: context,
              );
            },
          ).toList(),
        ],
      ),
    );
  }
}
