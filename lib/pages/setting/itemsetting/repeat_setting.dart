import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_check_hub/pages/setting/itemsetting/repeat_days.dart';
import 'package:flutter_check_hub/pages/setting/itemsetting/repeat_weeks.dart';

class RepeatSetting extends StatefulWidget {
  @override
  _RepeatSettingState createState() => _RepeatSettingState();
}

class _RepeatSettingState extends State<RepeatSetting> {
  final List<bool> _isSelected = <bool>[true, false, false];
  int segmentPage = 0;

  List<Widget> list = <Widget>[
    RepeatDays(),
    RepeatWeeks(),
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
            const SizedBox(
              height: 10.0,
            ),
            CupertinoSegmentedControl(
              children: {
                0: const Padding(
                    padding: EdgeInsets.only(left: 40.0, right: 40.0),
                    child: Text('Daily')),
                1: const Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Text('Weekly')),
                2: const Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Text('Interval')),
              },
              onValueChanged: (index) {
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
              groupValue: segmentPage,
            ),
            list[segmentPage],
          ],
        ));
  }
}
