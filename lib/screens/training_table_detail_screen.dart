import 'package:flutter/material.dart';

class TrainingTableDetailScreen extends StatelessWidget {
  static const routeName = '/training-table-detail';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Training Session Name',
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 5,
                ),
              ),
              SizedBox(height: 50),
              Container(
                width: 300,
                height: 350,
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
