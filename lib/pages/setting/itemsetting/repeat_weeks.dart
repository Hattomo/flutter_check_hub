import 'package:flutter/material.dart';

class RepeatWeeks extends StatefulWidget {
  @override
  _RepeatWeeksState createState() => _RepeatWeeksState();
}

class _RepeatWeeksState extends State<RepeatWeeks> {
  List<bool> isSelected = <bool>[false, false, false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    void chooseCallback(int index) {
      setState(() {
        for (int i = 0; i < isSelected.length; i++) {
          if (i == index) {
            isSelected[i] = true;
          } else {
            isSelected[i] = false;
          }
        }
      });
    }

    return Padding(
      padding: const EdgeInsets.only(left: 30.0, top: 8.0, right: 30.0),
      child: Column(
        children: <Widget>[
          RepeatWeeksTile(
              option: '1 Weeks',
              isSelected: isSelected[0],
              index: 0,
              callback: () => chooseCallback(0)),
          RepeatWeeksTile(
              option: '2 Weeks',
              isSelected: isSelected[1],
              index: 1,
              callback: () => chooseCallback(1)),
          RepeatWeeksTile(
              option: '3 Weeks',
              isSelected: isSelected[2],
              index: 2,
              callback: () => chooseCallback(2)),
          RepeatWeeksTile(
              option: '4 Weeks',
              isSelected: isSelected[3],
              index: 3,
              callback: () => chooseCallback(3)),
          RepeatWeeksTile(
              option: '5 Weeks',
              isSelected: isSelected[4],
              index: 4,
              callback: () => chooseCallback(4)),
          RepeatWeeksTile(
              option: '6 Weeks',
              isSelected: isSelected[5],
              index: 5,
              callback: () => chooseCallback(5)),
          RepeatWeeksTile(
              option: '7 Weeks',
              isSelected: isSelected[6],
              index: 6,
              callback: () => chooseCallback(6)),
        ],
      ),
    );
  }
}

@immutable
class RepeatWeeksTile extends StatefulWidget {
  const RepeatWeeksTile(
      {Key key, this.option, this.callback, this.index, this.isSelected})
      : super(key: key);
  final String option;
  final bool isSelected;
  final int index;
  final VoidCallback callback;
  @override
  _RepeatWeeksTileState createState() => _RepeatWeeksTileState();
}

class _RepeatWeeksTileState extends State<RepeatWeeksTile> {
  @override
  Widget build(BuildContext context) {
    print(widget.isSelected);
    return ListTile(
        title: Text(widget.option),
        trailing: widget.isSelected
            ? const Icon(
                Icons.check,
                color: Colors.blue,
              )
            : null,
        onTap: () {
          widget.callback();
        });
  }
}
