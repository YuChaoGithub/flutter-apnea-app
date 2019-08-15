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
      body: FutureBuilder(
        future: Provider.of<TrainingTableProvider>(context, listen: false)
            .fetchAndSetTable(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<TrainingTableProvider>(
                builder: (ctx, provider, ch) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ListView(
                      children:
                          List<Column>.generate(provider.tablesLength, (i) {
                        final table = provider.tables[i];
                        return table == TrainingTableProvider.defaultTable
                            ? Column()
                            : Column(
                                children: <Widget>[
                                  Dismissible(
                                    key: Key(table.key),
                                    background: Container(
                                      color: Theme.of(context).errorColor,
                                      child: Image.asset(
                                        'assets/icons/delete.png',
                                        scale: 20,
                                      ),
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.only(right: 20),
                                    ),
                                    direction: DismissDirection.endToStart,
                                    confirmDismiss: (direction) {
                                      return showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text('Alert',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700)),
                                          content: const Text(
                                              'Sure you want to delete this?'),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text('Don\'t Delete',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .button
                                                          .color)),
                                              onPressed: () =>
                                                  Navigator.of(ctx).pop(false),
                                            ),
                                            FlatButton(
                                              child: Text('Sure',
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .errorColor)),
                                              onPressed: () =>
                                                  Navigator.of(ctx).pop(true),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    onDismissed: (direction) =>
                                        provider.deleteTable(table.key),
                                    child: ListTile(
                                      key: Key(table.key),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            table.name,
                                            style: const TextStyle(
                                              fontFamily: 'Exo',
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            table.description,
                                            style:
                                                const TextStyle(fontSize: 14),
                                          )
                                        ],
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          TrainingTableDetailScreen.routeName,
                                          arguments: table.key,
                                        );
                                      },
                                    ),
                                  ),
                                  Divider(),
                                ],
                              );
                      }),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
