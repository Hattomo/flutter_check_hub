import 'package:flutter/material.dart';

class DataTypeSetting extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Type'),
      ),
      body: ListView.builder(
          itemCount: title.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(title[index]),
              onTap: () {},
            );
          }),
    );
  }
}
