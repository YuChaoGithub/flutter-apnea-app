import 'package:flutter/material.dart';

import '../models/minute_second.dart';
import '../widgets/timer_view_widget.dart';
import '../widgets/drawer_widget.dart';
import './breath_hold_test_history_screen.dart';

class BreathHoldTestScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breath Hold Test'),
        actions: <Widget>[
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
                    backgroundColor: Colors.blue,
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
            TimerViewWidget(MinuteSecond.fromString('33:33')),
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
                  color: Theme.of(context).textTheme.button.color,
                ),
                onPressed: () {},
              ),
            ),
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
                    instructions,
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
