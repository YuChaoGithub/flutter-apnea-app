import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './training_table_detail_screen.dart';
import '../providers/training_table_provider.dart';

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
      body: Consumer<TrainingTableProvider>(
        builder: (ctx, provider, ch) {
          return ListView(
            children: List<Column>.generate(provider.tablesLength, (i) {
              final table = provider.tables[i];
              return Column(
                children: <Widget>[
                  ListTile(
                    key: table.key,
                    title: Text(table.name, textAlign: TextAlign.center),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          TrainingTableDetailScreen.routeName,
                          arguments: table.key);
                    },
                  ),
                  Divider(),
                ],
              );
            }),
          );
        },
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
