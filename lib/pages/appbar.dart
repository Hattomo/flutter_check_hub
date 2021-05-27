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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showCalendar() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          DateTime _focusedDay = widget.dateTimeManager.selectedDate;
          DateTime _selectedDay = widget.dateTimeManager.selectedDate;
          CalendarFormat _calendarFormat = CalendarFormat.month;
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              decoration: const BoxDecoration(
                color: Color(0xFFEEF2F5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TableCalendar(
                    locale: 'en_US',
                    firstDay: DateTime(1970, 1, 1),
                    lastDay: DateTime(2100, 1, 1),
                    focusedDay: widget.dateTimeManager.selectedDate,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = widget.dateTimeManager.selectedDate;
                        });
                      }
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                    calendarStyle: const CalendarStyle(
                      todayTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    headerStyle: const HeaderStyle(
                      titleCentered: false,
                      formatButtonShowsNext: true,
                      // formatButtonDecoration: BoxDecoration(
                      //   color: Colors.blue[200],
                      //   borderRadius: BorderRadius.circular(5.0),
                      // ),
                    ),
                    calendarBuilders: CalendarBuilders(
                      selectedBuilder: (context, date, events) {
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
                      todayBuilder: (context, date, events) => Container(
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
                ],
              ),
            );
          });
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
      return AppBar(
        centerTitle: true,
        title: const Text('Check Hub'),
      );
    }
  }
}
