import 'package:flutter/material.dart';
import 'package:flutter_check_hub/pages/graph/graph_home.dart';
import 'package:flutter_check_hub/pages/setting/data_type_setting.dart';
import 'package:flutter_check_hub/pages/setting/edit_item_home.dart';
import 'package:flutter_check_hub/pages/setting/manage_item_home.dart';
import 'package:flutter_check_hub/pages/setting/record_home.dart';
import 'package:flutter_check_hub/pages/setting/repeat_setting.dart';
import 'package:flutter_check_hub/pages/setting/settings.dart';
import 'package:flutter_check_hub/service/date_time.dart';
import 'package:intl/intl.dart';

void main() => runApp(CheckHub());

class CheckHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CheckHub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => CheckHubHome(),
        '/manageItemHome': (BuildContext context) => ManageItemHome(),
        '/editItemHome': (BuildContext context) => EditItemHome(),
        '/dataTypeSetting': (BuildContext context) => DataTypeSetting(),
        '/repeatSetting': (BuildContext context) => RepeatSetting()
      },
    );
  }
}

class CheckHubHome extends StatefulWidget {
  @override
  _CheckHubHomeState createState() => _CheckHubHomeState();
}

class _CheckHubHomeState extends State<CheckHubHome>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  DateTimeManager dateTimeManager;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    dateTimeManager = DateTimeManager();
  }

  @override
  void dispose() {
    _tabController.dispose();
    dateTimeManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      dateTimeManager.subtractDate();
                    }),
                StreamBuilder<DateTime>(
                    stream: dateTimeManager.dateStream,
                    initialData: dateTimeManager.selectedDate,
                    builder: (BuildContext context,
                        AsyncSnapshot<DateTime> snapshot) {
                      return Column(
                        children: <Widget>[
                          Text(DateFormat('EEEE')
                              .format(dateTimeManager.selectedDate)),
                          Text(DateFormat('MMM d y')
                              .format(dateTimeManager.selectedDate)),
                        ],
                      );
                    }),
                IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      dateTimeManager.addDate();
                    }),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              RecordHome(),
              GraphHome(),
              Settings(),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: TabBar(
              controller: _tabController,
              indicatorWeight: 2.0,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              unselectedLabelStyle: const TextStyle(fontSize: 12.0),
              tabs: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.layers),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.insert_chart),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.settings),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
