import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_check_hub/service/auth_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

@immutable
class Settings extends StatelessWidget {
  final AuthService authService = AuthService();
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

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
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
            leading: const Icon(Icons.cloud),
            title: const Text('Export'),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {},
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
            trailing: FutureBuilder<String>(
              future: getinfo(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
                  Text(
                snapshot.hasData ? snapshot.data : 'Loading',
                style: const TextStyle(color: Colors.black, fontSize: 20.0),
              ),
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
            leading: const Icon(Icons.loyalty),
            title: const Text('Open Source Licence',
                style: TextStyle(color: Colors.black)),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {},
            ),
          ),
        ),
        Divider(
          color: Colors.grey[200],
          height: 0.8,
        ),
        const SizedBox(height: 20.0),
        InkWell(
          onTap: () async {
            authService.signOut();
          },
          child: Container(
            height: 50.0,
            color: Colors.white,
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Sign out',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
