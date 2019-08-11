import 'package:flutter/material.dart';

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
        title: const Text('History'),
        actions: <Widget>[
          IconButton(
            icon: Image.asset(
              'assets/icons/share.png',
              color: Theme.of(context).primaryIconTheme.color,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[],
      ),
    );
  }
}
