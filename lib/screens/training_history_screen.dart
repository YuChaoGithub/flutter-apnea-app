import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/training_history_provider.dart';
import './training_history_details_screen.dart';

class TrainingHistoryScreen extends StatelessWidget {
  static const routeName = '/training-history';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/back.png',
            color: Theme.of(context).primaryIconTheme.color,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Training History'),
      ),
      body: FutureBuilder(
        future: Provider.of<TrainingHistoryProvider>(context, listen: false)
            .fetchAndSetHistories(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<TrainingHistoryProvider>(
                builder: (ctx, provider, ch) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ListView(
                      children:
                          List<Column>.generate(provider.historiesLength, (i) {
                        final history = provider.histories[i];
                        return Column(
                          children: <Widget>[
                            Dismissible(
                              key: Key(history.key),
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
                                    title: const Text(
                                      'Alert',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
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
                                  provider.deleteHistory(history.key),
                              child: ListTile(
                                key: Key(history.key),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      history.name,
                                      style: const TextStyle(
                                        fontFamily: 'Exo',
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      DateFormat('yyyy-MM-dd HH:mm')
                                          .format(history.trainingDateTime),
                                      style: const TextStyle(fontSize: 14),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    TrainingHistoryDetailsScreen.routeName,
                                    arguments: history.key,
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

class TrainingHistoryTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('temp'),
          onTap: () {
            Navigator.of(context)
                .pushNamed(TrainingHistoryDetailsScreen.routeName);
          },
        ),
        Divider(),
      ],
    );
  }
}
