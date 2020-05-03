import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RepeatDays extends StatefulWidget {
  @override
  _RepeatDaysState createState() => _RepeatDaysState();
}

class _RepeatDaysState extends State<RepeatDays> {
  List<bool> isSelected = List<bool>.generate(7, (index) => false);

  @override
  Widget build(BuildContext context) {
    void isSelectedCallback(int index) {
      setState(() => isSelected[index] = !isSelected[index]);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RepeatDaysTile(
                option: 'Sundays',
                isSelected: isSelected[0],
                callback: () => isSelectedCallback(0)),
            RepeatDaysTile(
                option: 'Mondays',
                isSelected: isSelected[1],
                callback: () => isSelectedCallback(1)),
            RepeatDaysTile(
                option: 'Tuedays',
                isSelected: isSelected[2],
                callback: () => isSelectedCallback(2)),
            RepeatDaysTile(
                option: 'Wednesdays',
                isSelected: isSelected[3],
                callback: () => isSelectedCallback(3)),
            RepeatDaysTile(
                option: 'Thursdays',
                isSelected: isSelected[4],
                callback: () => isSelectedCallback(4)),
            RepeatDaysTile(
                option: 'Fridays',
                isSelected: isSelected[5],
                callback: () => isSelectedCallback(5)),
            RepeatDaysTile(
                option: 'Saturdays',
                isSelected: isSelected[6],
                callback: () => isSelectedCallback(6)),
            const SizedBox(
              height: 30.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: CupertinoButton(
                  child: const Text('Everydays'),
                  color: Colors.blue[400],
                  onPressed: () {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = true;
                      }
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

@immutable
class RepeatDaysTile extends StatefulWidget {
  const RepeatDaysTile({Key key, this.option, this.isSelected, this.callback})
      : super(key: key);
  final String option;
  final bool isSelected;
  final VoidCallback callback;
  @override
  _RepeatDaysTileState createState() => _RepeatDaysTileState();
}

class _RepeatDaysTileState extends State<RepeatDaysTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.option),
      trailing: widget.isSelected
          ? const Icon(
              Icons.check,
              color: Colors.blue,
            )
          : null,
      onTap: () => setState(() => widget.callback()),
    );
  }
}
