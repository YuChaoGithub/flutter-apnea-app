import 'package:flutter/material.dart';

import '../widgets/progress_bar.dart';
import '../widgets/timer_widget.dart';
import '../widgets/drawer_widget.dart';
import './customize_tables_screen.dart';
import './training_history_screen.dart';

class TrainingScreen extends StatelessWidget {
  static const routeName = '/training';

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
            onPressed: () {
              Navigator.of(context).pushNamed(CustomizeTableScreen.routeName);
            },
          ),
          IconButton(
            icon: Icon(Icons.history),
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
            TimerWidget(),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text('Contraction starts at 2:30'),
            ),
            SizedBox(height: 10),
            ProgressBar(),
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
            SizedBox(height: 5),
            DropdownButton(
              items: [
                DropdownMenuItem(child: Text('Table 1')),
              ],
              onChanged: (val) {},
            ),
            SizedBox(height: 10),
            TrainingTableWidget(),
          ],
        ),
      ),
    );
  }
}

class TrainingTableWidget extends StatelessWidget {
  TableRow _buildTableRow(String index, String holdTime, String breatheTime,
      {bool isTitle = false}) {
    return TableRow(
      decoration: isTitle
          ? BoxDecoration(border: Border(bottom: BorderSide(width: 1)))
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
          _buildTableRow('#', 'Hold', 'Breathe', isTitle: true),
          _buildTableRow('1', '3:32', '5:58'),
          _buildTableRow('2', '3:32', '5:58'),
          _buildTableRow('3', '3:32', '5:58'),
          _buildTableRow('4', '3:32', '5:58'),
          _buildTableRow('5', '3:32', '5:58'),
          _buildTableRow('6', '3:32', '5:58'),
        ],
      ),
    );
  }
}
