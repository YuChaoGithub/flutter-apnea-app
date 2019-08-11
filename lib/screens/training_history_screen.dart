import 'package:flutter/material.dart';

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
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (ctx, i) {
          return TrainingHistoryTile();
        },
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
