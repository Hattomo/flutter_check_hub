import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/Item.dart';
import 'package:flutter_check_hub/pages/recordhome/item_list.dart';
import 'package:flutter_check_hub/service/data_store_service.dart';
import 'package:provider/provider.dart';

class RecordHome extends StatefulWidget {
  @override
  _RecordHomeState createState() => _RecordHomeState();
}

class _RecordHomeState extends State<RecordHome> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Item>>.value(
      value: DatabaseServiceItem().items,
      child: Container(
        child: ItemList(),
      ),
    );
  }
}
