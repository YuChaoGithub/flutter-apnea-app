import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/drawer_widget.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings-screen';

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      drawer: DrawerWidget(),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 10),
          SettingsListTile(
            title: 'Support Website',
            tapAction: () =>
                _launchURL('http://shinerightstudio.com/apnea-app'),
          ),
          ListTile(
            title: const Text(
              'Version: 1.0',
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
