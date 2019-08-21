import 'dart:async';

import 'package:apnea/widgets/inspire_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/breath_hold_history_provider.dart';
import '../models/minute_second.dart';
import '../models/breath_hold_history_data.dart';
import '../widgets/control_button.dart';
import '../widgets/timer_view_widget.dart';
import '../widgets/drawer_widget.dart';
import './breath_hold_test_history_screen.dart';

class BreathHoldTestScreen extends StatefulWidget {
  static const routeName = '/breath-hold-test';

  static const instructions = '''
Instructions:

1. Lay on your comfy bed!

2. Breathe slowly for 2 minutes!

3. Take a DEEP breath in and exhale the hell out of it!

4. Take an extremely DEEEEP breath in and HOLD!

5. Press the play button!

6. Tap the Lungs button when you feel diaphragm contractions! Congrats on that by the way!

7. If you can't hold the beast in anymore, press the stop button, exhale and adjust your breath for a couple of minutes!

The app creator won't be held responsible if you suffocate and die! So take care of your own health conditions!''';

  @override
  _BreathHoldTestScreenState createState() => _BreathHoldTestScreenState();
}

class _BreathHoldTestScreenState extends State<BreathHoldTestScreen> {
  static const _timerDelay = Duration(microseconds: 1);
  Timer _timer;
  MinuteSecond _contractionTime;
  MinuteSecond _currTime;
  Stopwatch _stopwatch = Stopwatch();

  void _startWatch() {
    _stopwatch.start();
  }

  void _completeSession() {
    _stopwatch
      ..stop()
      ..reset();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text(
            'Complete!',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          content: const Text('Save this session?'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Don\'t Save',
                style: TextStyle(
                  color: Theme.of(context).errorColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                'Save',
                style: TextStyle(
                  color: Theme.of(context).textTheme.button.color,
                ),
              ),
              onPressed: () {
                final history = BreathHoldHistoryData(
                  key: UniqueKey().toString(),
                  firstContraction: _contractionTime,
                  holdDuration: _currTime,
                  testDateTime: DateTime.now(),
                );
                Provider.of<BreathHoldHistoryProvider>(context)
                    .addHistory(history)
                    .then((_) {
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    ).then((_) {
      setState(() {
        _currTime = null;
        _contractionTime = null;
      });
    });
  }

  void _recordContractionTime() {
    _contractionTime = _currTime;
  }

  void _update() {
    if (_stopwatch.isRunning) {
      setState(() => _currTime = MinuteSecond.fromDuration(_stopwatch.elapsed));
    }
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
        title: const Text('Breath Hold Test'),
        actions: _stopwatch.isRunning
            ? []
            : <Widget>[
                IconButton(
                  icon: Image.asset(
                    'assets/icons/history.png',
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(BreathHoldTestHistoryScreen.routeName);
                  },
                ),
              ],
      ),
      drawer: _stopwatch.isRunning ? null : DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              _stopwatch.isRunning ? 'Hold' : 'Prepare',
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
                  onPressed: _contractionTime == null && _stopwatch.isRunning
                      ? _recordContractionTime
                      : null,
                ),
                SizedBox(width: 30),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).textTheme.title.color,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Image.asset(
                      _stopwatch.isRunning
                          ? 'assets/images/hold.png'
                          : 'assets/images/prepare.png',
                      color: Theme.of(context).textTheme.title.color,
                    ),
                  ),
                ),
                SizedBox(width: 30),
                InspireButton(),
              ],
            ),
            SizedBox(height: 10),
            TimerViewWidget(_currTime),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: _contractionTime == null
                  ? Container()
                  : Text(
                      'Contraction started at ${_contractionTime.toString()}.',
                    ),
            ),
            SizedBox(height: 10),
            _stopwatch.isRunning
                ? ControlButton('assets/icons/check.png', _completeSession)
                : ControlButton('assets/icons/play.png', _startWatch),
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 300,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    width: 2,
                    color: Theme.of(context).textTheme.title.color,
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    BreathHoldTestScreen.instructions,
                    style: const TextStyle(
                        fontFamily: 'Delius Unicase',
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
