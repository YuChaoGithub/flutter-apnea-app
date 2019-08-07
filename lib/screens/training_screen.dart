import 'package:apnea/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class TrainingScreen extends StatelessWidget {
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
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {},
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
                  icon: Icon(Icons.speaker),
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
                  icon: Icon(Icons.storage),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: 180,
              height: 80,
              child: Card(
                elevation: 5,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 10,
              color: Colors.blue,
            ),
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
            SizedBox(height: 10),
            Card(
              child: Text('Dropdown Menu'),
            ),
            SizedBox(height: 20),
            Container(
              color: Colors.red,
              width: 275,
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}
