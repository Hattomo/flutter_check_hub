import 'package:flutter/material.dart';

class DataTypeSetting extends StatefulWidget {
  @override
  _DataTypeSettingState createState() => _DataTypeSettingState();
}

class _DataTypeSettingState extends State<DataTypeSetting> {
  List<bool> isSelected = List<bool>.generate(10, (int index) => false);

  @override
  Widget build(BuildContext context) {
    final List<String> title = <String>[
      'Number',
      'Slider only Max',
      'Double Number', //e.x. stock price
      'Total Number',
      'Time', //e.x. 2 hours
      'Total Time',
      'Checkbox',
      'Slider step by step',
      'Text',
      'Countup'
    ];

    String getindex() {
      String index = '';
      for (int i = 0; i < 10; i++) {
        if (isSelected[i] == true) {
          print(i);
          index = title[i];
        }
      }
      return index;
    }

    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () async {
              final String index = getindex();
              Navigator.pop<String>(context, index);
            },
          ),
        ),
        centerTitle: true,
        title: const Text('Data Type'),
      ),
      body: ListView.builder(
          itemCount: title.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(title[index]),
              trailing: isSelected[index]
                  ? const Icon(
                      Icons.check,
                      color: Colors.blue,
                    )
                  : null,
              onTap: () => setState(() {
                for (int i = 0; i < isSelected.length; i++) {
                  if (i == index) {
                    isSelected[i] = true;
                  } else {
                    isSelected[i] = false;
                  }
                }
              }),
            );
          }),
    );
  }
}
