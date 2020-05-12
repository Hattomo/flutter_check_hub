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

  int touchedGroupIndex;

  Future<List<BarChartGroupData>> getBarGroupData() async {
    final List<BarChartGroupData> items = [];
    await databaseServiceItem.getListItemdata(widget.itemData.id).then((value) {
      for (int i = 0; i < value.length; i++) {
        items.add(makeGroupData(i, double.parse(value[i][0])));
      }
      print(items);
    });
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
                    'This Week',
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
                            maxY: 20,
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: SideTitles(
                                showTitles: true,
                                textStyle: const TextStyle(
                                    color: Color(0xff7589a2),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                margin: 20,
                                getTitles: (double value) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return 'Mn';
                                    case 1:
                                      return 'Te';
                                    case 2:
                                      return 'Wd';
                                    case 3:
                                      return 'Tu';
                                    case 4:
                                      return 'Fr';
                                    case 5:
                                      return 'St';
                                    case 6:
                                      return 'Sn';
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
                                getTitles: (value) {
                                  if (value == 0) {
                                    return '0K';
                                  } else if (value == 10) {
                                    return '5K';
                                  } else if (value == 19) {
                                    return '10K';
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
