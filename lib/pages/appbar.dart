import 'package:flutter/material.dart';
import 'package:flutter_check_hub/service/date_time.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

const double _preferredHeight = 60.0;

@immutable
class CheckHubAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CheckHubAppBar(this.dateTimeManager, this.tabControllerindex);
  final DateTimeManager dateTimeManager;
  final int tabControllerindex;

  @override
  Size get preferredSize => const Size.fromHeight(_preferredHeight);
  @override
  _CheckHubAppBarState createState() => _CheckHubAppBarState();
}

class _CheckHubAppBarState extends State<CheckHubAppBar> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
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
              initialSelectedDay: widget.dateTimeManager.selectedDate,
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
                  widget.dateTimeManager.setDate(date);
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
    final int tabindex = widget.tabControllerindex;
    print(widget.tabControllerindex);
    if (tabindex == 0) {
      return AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  widget.dateTimeManager.subtractDate();
                }),
            StreamBuilder<DateTime>(
                stream: widget.dateTimeManager.dateStream,
                initialData: widget.dateTimeManager.selectedDate,
                builder:
                    (BuildContext context, AsyncSnapshot<DateTime> snapshot) {
                  return InkWell(
                    onTap: () => showCalendar(),
                    child: Column(
                      children: <Widget>[
                        Text(DateFormat('EEEE')
                            .format(widget.dateTimeManager.selectedDate)),
                        Text(DateFormat('MMM d y')
                            .format(widget.dateTimeManager.selectedDate)),
                      ],
                    ),
                  );
                }),
            IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  widget.dateTimeManager.addDate();
                }),
          ],
        ),
      );
    } else if (tabindex == 1) {
      return AppBar(
        centerTitle: true,
        title: const Text('Recent 30 days'),
      );
    } else if (tabindex == 2) {
      return AppBar(
        centerTitle: true,
        title: const Text('Settings'),
      );
    } else {
      return null;
    }
  }
}
