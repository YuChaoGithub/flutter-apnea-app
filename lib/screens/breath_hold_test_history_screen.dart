import 'package:flutter/material.dart';

class BreathHoldTestHistoryScreen extends StatelessWidget {
  static const routeName = '/breath-hold-test-history';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
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
