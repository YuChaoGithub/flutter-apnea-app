import 'package:flutter/material.dart';

import '../models/minute_second.dart';
import '../widgets/timer_widget.dart';
import '../widgets/drawer_widget.dart';
import './breath_hold_test_history_screen.dart';

class BreathHoldTestScreen extends StatelessWidget {
  static const routeName = '/breath-hold-test';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breath Hold Test'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(BreathHoldTestHistoryScreen.routeName);
            },
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  icon: Icon(Icons.style),
                  onPressed: () {},
                ),
                SizedBox(width: 30),
                Container(
                  width: 70,
                  height: 70,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                ),
                SizedBox(width: 30),
                IconButton(
                  icon: Icon(Icons.storage),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 10),
            TimerWidget(MinuteSecond(minute: 9, second: 5)),
            SizedBox(height: 20),
            Container(
              height: 70,
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                shape: CircleBorder(),
                child: Icon(Icons.play_arrow),
                onPressed: () {},
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 275,
              height: 300,
              child: Text('Instructions:\n1. Hold Hold Hold do the Hold Hold Hold.\n2. OK.'),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
