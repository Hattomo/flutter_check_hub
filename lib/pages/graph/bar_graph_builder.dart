import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/Item.dart';
import 'package:flutter_check_hub/service/data_store_service.dart';

@immutable
class BarGraphBuilder extends StatefulWidget {
  const BarGraphBuilder(this.itemData);
  final ItemData itemData;
  @override
  State<StatefulWidget> createState() => BarGraphBuilderState();
}

class BarGraphBuilderState extends State<BarGraphBuilder> {
  final Color leftBarColor = Colors.blue;
  final double width = 8;
  final DatabaseServiceItem databaseServiceItem = DatabaseServiceItem();
  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;
  double maxvalue;
  double minvalue;
  int touchedGroupIndex;

  Future<List<BarChartGroupData>> getBarGroupData() async {
    final List<BarChartGroupData> items = [];
    await databaseServiceItem.getListItemdata(widget.itemData.id).then((value) {
      final int date = DateTime.now().difference(DateTime(2020, 1, 1)).inDays;
      int cnt = 0;
      int listindex = 0;
      // get max
      for (int i = date - 30; i <= date; i++) {
        print(cnt);
        if (listindex < value.length) {
          if ((value[listindex][2]).toInt() != i) {
            items.add(makeGroupData(cnt, 0));
            print('$cnt:0');
          } else if ((value[listindex][2]).toInt() == i) {
            items.add(makeGroupData(cnt, double.parse(value[listindex][0])));
            print('$cnt:${value[listindex][0]}');
            if (listindex == 0) {
              maxvalue = double.parse(value[listindex][0]);
            } else if (double.parse(value[listindex][0]) > maxvalue) {
              maxvalue = double.parse(value[listindex][0]);
            }
            listindex++;
          }
          print(listindex);
        } else {
          items.add(makeGroupData(cnt, 0));
        }
        cnt++;
      }
      print(items.length);
    });
    print(items);
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.itemData.icon,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(
                    width: 38,
                  ),
                  Text(
                    widget.itemData.title,
                    style: const TextStyle(color: Colors.black, fontSize: 22),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(
                    'This Month',
                    style: TextStyle(color: Color(0xff77839a), fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 38,
              ),
              FutureBuilder(
                future: getBarGroupData(),
                builder: (context, snapahot) {
                  if (snapahot.hasData) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: BarChart(
                          BarChartData(
                            maxY: maxvalue * 1.1,
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: SideTitles(
                                showTitles: true,
                                textStyle: const TextStyle(
                                    color: Color(0xff7589a2),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                margin: 20,
                                reservedSize: 14.0,
                                getTitles: (double value) {
                                  print(value);
                                  switch (value.toInt()) {
                                    case 1:
                                      return '30';
                                    case 5:
                                      return '25';
                                    case 10:
                                      return '20';
                                    case 15:
                                      return '15';
                                    case 20:
                                      return '10';
                                    case 25:
                                      return '5';
                                    case 29:
                                      return '1';
                                    default:
                                      return '';
                                  }
                                },
                              ),
                              leftTitles: SideTitles(
                                showTitles: true,
                                textStyle: const TextStyle(
                                    color: Color(0xff7589a2),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                margin: 32,
                                reservedSize: 14,
                                getTitles: (double value) {
                                  if (value == 0) {
                                    return '0';
                                  } else if (value == maxvalue / 2) {
                                    return (maxvalue / 2).toString();
                                  } else if (value == maxvalue) {
                                    return maxvalue.toString();
                                  } else {
                                    return '';
                                  }
                                },
                              ),
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            barGroups: snapahot.data,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Center(child: CupertinoActivityIndicator());
                  }
                },
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        color: leftBarColor,
        width: width,
      ),
    ]);
  }
}
