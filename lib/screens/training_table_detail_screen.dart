import 'package:flutter/material.dart';

class TrainingTableDetailScreen extends StatelessWidget {
  static const routeName = '/training-table-detail';
  static const durationSelections = [
    '0:30',
    '0:45',
    '1:00',
    '1:15',
    '1:30',
    '1:45',
    '2:00',
    '2:15',
    '2:30',
    '2:45',
    '3:00',
    '3:15',
    '3:30',
    '3:45',
    '4:00',
    '4:15',
    '4:30',
    '4:45',
    '5:00',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/back.png',
            color: Theme.of(context).iconTheme.color,
          ),
          color: Theme.of(context).errorColor,
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: const Text('Alert'),
                  content: const Text('Exit without saving?'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        'Continue Editing',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.button.color,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        'Sure',
                        style: TextStyle(
                          color: Theme.of(context).errorColor,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset(
              'assets/icons/check.png',
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {},
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50.0,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Training Session Name',
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50.0,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 5,
                ),
              ),
              SizedBox(height: 50),
              TrainingTableInputWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class TrainingTableInputWidget extends StatelessWidget {
  TableRow _buildTableRow(int index) {
    return TableRow(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            '$index',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
        DurationDropDownMenu(),
        DurationDropDownMenu(),
      ],
    );
  }

  Widget _buildTableText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        columnWidths: {0: FractionColumnWidth(0.1)},
        children: <TableRow>[
          TableRow(
            decoration:
                BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
            children: <Widget>[
              _buildTableText('#'),
              _buildTableText('Hold'),
              _buildTableText('Breathe'),
            ],
          ),
          _buildTableRow(1),
          _buildTableRow(2),
          _buildTableRow(3),
          _buildTableRow(4),
          _buildTableRow(5),
          _buildTableRow(6),
        ],
      ),
    );
  }
}

class DurationDropDownMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: DropdownButton(
        items: TrainingTableDetailScreen.durationSelections.map((val) {
          return DropdownMenuItem(child: Text(val));
        }).toList(),
        onChanged: (val) {},
        underline: Container(
          height: 1.0,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).textTheme.title.color,
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
