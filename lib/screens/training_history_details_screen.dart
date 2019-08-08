import 'package:flutter/material.dart';

class TrainingHistoryDetailsScreen extends StatelessWidget {
  static const routeName = '/training-history-details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
