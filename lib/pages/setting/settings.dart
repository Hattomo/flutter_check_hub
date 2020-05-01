import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<String> getinfo() async {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      //String appName = packageInfo.appName;
      //String packageName = packageInfo.packageName;
      final String version = packageInfo.version;
      //final String buildNumber = packageInfo.buildNumber;
      return version;
    }

    getinfo();

    return ListView(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Item'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushNamed(context, '/manageItemHome'),
          ),
        ),
        Divider(
          color: Colors.grey[200],
          height: 0.8,
        ),
        Container(
          color: Colors.white,
          child: const ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification', style: TextStyle(color: Colors.black)),
            trailing: CupertinoSwitch(
              value: true,
              onChanged: null,
              activeColor: Colors.blue,
            ),
          ),
        ),
        Divider(
          color: Colors.grey[200],
          height: 0.8,
        ),
        Container(
          color: Colors.white,
          child: ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Version'),
            trailing: FutureBuilder(
              future: getinfo(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
                  Text(
                snapshot.hasData ? snapshot.data : 'Loading',
                style: const TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        Container(
          color: Colors.white,
          child: const ListTile(
            leading: Text(''),
          ),
        ),
      ],
    );
  }
}