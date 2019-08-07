import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
            ),
            Divider(),
            ListTile(
              title: Text('Training'),
              leading: Icon(Icons.train),
              onTap: () {},
            ),
            ListTile(
              title: Text('Breath Hold Test'),
              leading: Icon(Icons.tag_faces),
              onTap: () {},
            ),
            ListTile(
              title: Text('Training'),
              leading: Icon(Icons.settings),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
