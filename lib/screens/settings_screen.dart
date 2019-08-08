import 'package:flutter/material.dart';

import '../widgets/drawer_widget.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      drawer: DrawerWidget(),
      body: ListView(
        children: <Widget>[
          SettingsListTile(title: 'Prepare Time'),
          SettingsListTile(
            title: 'Vibration',
            trailing: Switch(
              value: true,
              onChanged: (value) {},
            ),
          ),
          SettingsListTile(
            title: 'Speech',
            trailing: Switch(
              value: true,
              onChanged: (value) {},
            ),
          ),
          SettingsListTile(title: 'References', tapAction: () {}),
          SettingsListTile(title: 'Contact', tapAction: () {}),
          ListTile(
            title: const Text(
              'Version: 0.1',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsListTile extends StatelessWidget {
  final String title;
  final Widget trailing;
  final Function tapAction;

  SettingsListTile({@required this.title, this.trailing, this.tapAction});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(title, style: TextStyle(fontSize: 18)),
          trailing: trailing,
          onTap: tapAction,
        ),
        Divider(),
      ],
    );
  }
}
