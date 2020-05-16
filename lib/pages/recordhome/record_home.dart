import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/user.dart';
import 'package:flutter_check_hub/pages/recordhome/item_list.dart';
import 'package:flutter_check_hub/pages/setting/create_item_home.dart';
import 'package:flutter_check_hub/service/date_time.dart';
import 'package:provider/provider.dart';

class RecordHome extends StatefulWidget {
  const RecordHome({this.dateTimeManager});
  final DateTimeManager dateTimeManager;
  @override
  _RecordHomeState createState() => _RecordHomeState();
}

class _RecordHomeState extends State<RecordHome> {
  Offset beginningDragPosition = Offset.zero;
  Offset updatingDragPosition = Offset.zero;

  void onHorizontalDragStart(DragStartDetails details) {
    beginningDragPosition = details.globalPosition;
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    updatingDragPosition = Offset(
      details.globalPosition.dx - beginningDragPosition.dx,
      details.globalPosition.dy - beginningDragPosition.dy,
    );
  }

  void onHorizontalDragEnd(DragEndDetails details) {
    if (updatingDragPosition.dx > 100.0) {
      widget.dateTimeManager.subtractDate();
    } else if (updatingDragPosition.dx < -100.0) {
      widget.dateTimeManager.addDate();
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserData user = Provider.of(context);

    void showCreateItem() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return CreateItemHome(user: user);
          },
          fullscreenDialog: true,
        ),
      );
    }

    return GestureDetector(
      onHorizontalDragStart: onHorizontalDragStart,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                child: ItemList(),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          onPressed: () => showCreateItem(),
        ),
      ),
    );
  }
}
