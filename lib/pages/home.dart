import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/user.dart';
import 'package:flutter_check_hub/pages/appbar.dart';
import 'package:flutter_check_hub/pages/graph/graph_home.dart';
import 'package:flutter_check_hub/pages/recordhome/record_home.dart';
import 'package:flutter_check_hub/pages/setting/settings.dart';
import 'package:flutter_check_hub/service/date_time.dart';
import 'package:flutter_check_hub/service/user_dataservice.dart';
import 'package:provider/provider.dart';

class CheckHubHome extends StatefulWidget {
  @override
  _CheckHubHomeState createState() => _CheckHubHomeState();
}

class _CheckHubHomeState extends State<CheckHubHome>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  DateTimeManager dateTimeManager;
  int index = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3)
      ..addListener(() => setState(() {
            index = tabController.index;
          }));
    dateTimeManager = DateTimeManager();
  }

  @override
  void dispose() {
    tabController.dispose();
    dateTimeManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return StreamProvider.value(
      value: DatabaseServiceUser().user(user),
      child: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: CheckHubAppBar(dateTimeManager, tabController.index),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: <Widget>[
                StreamProvider.value(
                  initialData: dateTimeManager.selectedDate,
                  value: dateTimeManager.dateStream,
                  child: RecordHome(
                    dateTimeManager: dateTimeManager,
                  ),
                ),
                GraphHome(),
                Settings(),
              ],
            ),
            bottomNavigationBar: SafeArea(
              child: TabBar(
                controller: tabController,
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
      ),
    );
  }
}
