import 'package:flutter/material.dart';

class RepeatSetting extends StatefulWidget {
  @override
  _RepeatSettingState createState() => _RepeatSettingState();
}

class _RepeatSettingState extends State<RepeatSetting> {
  final List<bool> _isSelected = <bool>[true, false, false];
  int segmentPage = 0;

  List<Widget> list = <Widget>[
    Column(
      children: <Widget>[
        const ListTile(title: Text('day')),
        const ListTile(title: Text('day')),
        const ListTile(title: Text('day')),
        const ListTile(title: Text('day')),
        const ListTile(title: Text('day')),
        const ListTile(title: Text('day')),
        const ListTile(title: Text('day')),
      ],
    ),
    Column(
      children: <Widget>[
        const ListTile(title: Text('Week')),
        const ListTile(title: Text('Week')),
        const ListTile(title: Text('Week')),
        const ListTile(title: Text('Week')),
        const ListTile(title: Text('Week')),
        const ListTile(title: Text('Week')),
        const ListTile(title: Text('Week')),
      ],
    ),
    Column(
      children: <Widget>[
        const ListTile(title: Text('Sunday')),
        const ListTile(title: Text('Sunday')),
        const ListTile(title: Text('Sunday')),
        const ListTile(title: Text('Sunday')),
        const ListTile(title: Text('Sunday')),
        const ListTile(title: Text('Sunday')),
        const ListTile(title: Text('Sunday')),
      ],
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Repeat Setting'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: ToggleButtons(
                isSelected: _isSelected,
                children: <Widget>[
                  const Text('Daily'),
                  const Text('Weekly'),
                  const Text('interval')
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0;
                        buttonIndex < _isSelected.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        _isSelected[buttonIndex] = true;
                        segmentPage = buttonIndex;
                      } else {
                        _isSelected[buttonIndex] = false;
                      }
                    }
                  });
                },
              ),
            ),
            list[segmentPage],
          ],
        ));
  }
}
