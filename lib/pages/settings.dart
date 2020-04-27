import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          child: const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Version 0.0.0', style: TextStyle(color: Colors.black)),
          ),
        )
      ],
    );
  }
}
