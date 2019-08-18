import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/breath_hold_history_provider.dart';

class BreathHoldTestHistoryScreen extends StatelessWidget {
  static const routeName = '/breath-hold-test-history';

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
        title: const Text('Breath Hold History'),
      ),
      body: FutureBuilder(
        future: Provider.of<BreathHoldHistoryProvider>(context, listen: false)
            .fetchAndSetHistory(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<BreathHoldHistoryProvider>(
                builder: (ctx, provider, ch) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ListView(
                      children: List<Column>.generate(
                        provider.historiesLength,
                        (i) {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        DateFormat('yyyy-MM-dd HH:mm')
                                            .format(history.testDateTime),
                                        style: const TextStyle(
                                          fontFamily: 'Exo',
                                          fontSize: 18,
                                        ),
                                      ),
                                      if (!history.firstContraction.isNull())
                                        const SizedBox(height: 10),
                                      if (!history.firstContraction.isNull())
                                        Text(
                                            'Diaphragm contraction started at ${history.firstContraction.toString()}.'),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Breath held for ${history.holdDuration.toString()}.',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
