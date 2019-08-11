import 'package:flutter/material.dart';

import './training_table_detail_screen.dart';

class CustomizeTableScreen extends StatelessWidget {
  static const routeName = '/customize-table';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/back.png',
            color: Theme.of(context).primaryIconTheme.color,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Training Tables'),
        actions: <Widget>[
          IconButton(
            icon: Image.asset(
              'assets/icons/add.png',
              color: Theme.of(context).primaryIconTheme.color,
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(TrainingTableDetailScreen.routeName);
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[],
      ),
    );
  }
}

class TableListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('temp'),
      onTap: () {},
    );
  }
}
