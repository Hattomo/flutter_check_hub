import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/Item.dart';
import 'package:flutter_check_hub/service/data_store_service.dart';

@immutable
class DataListView extends StatefulWidget {
  const DataListView({this.datalist, this.item});
  final List<dynamic> datalist;
  final Item item;
  @override
  _DataListViewState createState() => _DataListViewState();
}

class _DataListViewState extends State<DataListView> {
  final dateTime = DateTime.now();
  final datebaseServiceItem = DatabaseServiceItem();
  Widget weekDay(int weekday) {
    if (weekday == 0)
      return const Text('Sun');
    else if (weekday == 1)
      return const Text('Mon');
    else if (weekday == 2)
      return const Text('Tue');
    else if (weekday == 3)
      return const Text('Wed');
    else if (weekday == 4)
      return const Text('Thu');
    else if (weekday == 5)
      return const Text('Fri');
    else
      return const Text('Sat');
  }

  @override
  Widget build(BuildContext context) {
    return widget?.datalist?.length != null
        ? Scaffold(
            appBar: AppBar(),
            body: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: 30,
                itemBuilder: (context, index) {
                  print('66');
                  final int date = DateTime(2020, 5, index + 1)
                      .difference(DateTime(2020, 1, 1))
                      .inDays;
                  String displaytext;
                  displaytext = 'No Data';
                  for (int j = 0; j < widget.datalist.length; j++) {
                    if (widget.datalist[j][2] == date) {
                      displaytext = widget.datalist[j][0];
                    }
                  }
                  return ListTile(
                    title: displaytext == 'No Data'
                        ? Center(
                            child: Text(
                            displaytext,
                            style: TextStyle(color: Colors.grey[400]),
                          ))
                        : Center(
                            child: Text(
                              '$displaytext  ${widget.item.unit}',
                            ),
                          ),
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('${index + 1}',
                              style: const TextStyle(fontSize: 20.0)),
                          weekDay(DateTime(2020, 5, index + 1).weekday)
                        ],
                      ),
                    ),
                    onTap: () {},
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.grey,
                    height: 0.8,
                  );
                }),
          )
        : Scaffold(
            body: FutureBuilder(
            future: datebaseServiceItem.getListItemdata(widget.item.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return DataListView(
                    item: widget.item,
                    datalist: snapshot.data,
                  );
                } else {
                  return const Center(
                    child: Text('NetWorkError'),
                  );
                }
              } else {
                return const Center(child: CupertinoActivityIndicator());
              }
            },
          ));
  }
}
