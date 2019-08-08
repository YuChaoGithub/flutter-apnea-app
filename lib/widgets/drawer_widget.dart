import 'package:flutter/material.dart';

import '../screens/breath_hold_test_screen.dart';
import '../screens/training_screen.dart';
import '../screens/settings_screen.dart';

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
            DrawerItem(
              title: 'Apnea Training',
              icon: Icon(Icons.train),
              targetRoute: TrainingScreen.routeName,
            ),
            DrawerItem(
              title: 'Breath Hold Test',
              icon: Icon(Icons.tag_faces),
              targetRoute: BreathHoldTestScreen.routeName,
            ),
            DrawerItem(
              title: 'Settings',
              icon: Icon(Icons.settings),
              targetRoute: SettingsScreen.routeName,
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final Icon icon;
  final String targetRoute;

  DrawerItem({
    @required this.title,
    @required this.icon,
    @required this.targetRoute,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 18),
      ),
      leading: icon,
      onTap: () => Navigator.of(context).pushReplacementNamed(targetRoute),
    );
  }
}
