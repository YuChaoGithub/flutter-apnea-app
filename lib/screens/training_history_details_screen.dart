import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/training_history_provider.dart';

class TrainingHistoryDetailsScreen extends StatelessWidget {
  static const routeName = '/training-history-details';

  @override
  Widget build(BuildContext context) {
    final historyKey = ModalRoute.of(context).settings as String;
    final history = Provider.of<TrainingHistoryProvider>(context, listen: false)
        .getHistory(historyKey);

    return Scaffold(
      appBar: AppBar(
        title: Text(history.name),
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/back.png',
            color: Theme.of(context).primaryIconTheme.color,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset(
              'asset/icons/share.png',
              color: Theme.of(context).primaryIconTheme.color,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
