import 'package:flutter/material.dart';

class TrainingHistoryDetailsScreen extends StatelessWidget {
  static const routeName = '/training-history-details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
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
    );
  }
}
