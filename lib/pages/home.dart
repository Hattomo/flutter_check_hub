import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/user.dart';
import 'package:flutter_check_hub/pages/graph/graph_home.dart';
import 'package:flutter_check_hub/pages/recordhome/record_home.dart';
import 'package:flutter_check_hub/pages/setting/settings.dart';
import 'package:flutter_check_hub/service/date_time.dart';
import 'package:flutter_check_hub/service/user_dataservice.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CheckHubHome extends StatefulWidget {
  @override
  _CheckHubHomeState createState() => _CheckHubHomeState();
}

class _CheckHubHomeState extends State<CheckHubHome>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  DateTimeManager dateTimeManager;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _calendarController = CalendarController();
    dateTimeManager = DateTimeManager();
  }

  @override
  void dispose() {
    _tabController.dispose();
    dateTimeManager.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void showCalendar() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            //height: MediaQuery.of(context).size.height*(3/4),
            decoration: const BoxDecoration(
              color: Color(0xFFEEF2F5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: TableCalendar(
              calendarController: _calendarController,
              locale: 'en_US',
              initialSelectedDay: dateTimeManager.selectedDate,
              initialCalendarFormat: CalendarFormat.month,
              calendarStyle: const CalendarStyle(
                todayStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              headerStyle: const HeaderStyle(
                centerHeaderTitle: true,
                formatButtonShowsNext: true,
                //formatButtonDecoration: BoxDecoration(
                //color: Colors.blue[200],
                //borderRadius: BorderRadius.circular(5.0),
                //),
              ),
              onDaySelected: (date, events) {
                print(date.toIso8601String());
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) {
                  dateTimeManager.setDate(date);
                  return Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.pink[300],
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: const TextStyle(color: Colors.white),
                      ));
                },
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: const TextStyle(color: Colors.black),
                    )),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    print(user.uid);
    return StreamProvider.value(
      value: DatabaseServiceUser().user(user),
      child: DefaultTabController(
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
                        return InkWell(
                          onTap: () => showCalendar(),
                          child: Column(
                            children: <Widget>[
                              Text(DateFormat('EEEE')
                                  .format(dateTimeManager.selectedDate)),
                              Text(DateFormat('MMM d y')
                                  .format(dateTimeManager.selectedDate)),
                            ],
                          ),
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
      ),
    );
  }
}
