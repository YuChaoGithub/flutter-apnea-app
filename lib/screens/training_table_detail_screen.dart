import 'package:flutter/material.dart';

class TrainingTableDetailScreen extends StatelessWidget {
  static const routeName = '/training-table-detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
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
        items: [
          DropdownMenuItem(
            child: Text(
              '2:30',
            ),
          )
        ],
        onChanged: (val) {},
      ),
    );
  }
}
