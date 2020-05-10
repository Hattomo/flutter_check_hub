import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/user.dart';
import 'package:flutter_check_hub/pages/recordhome/item_list.dart';
import 'package:flutter_check_hub/pages/setting/create_item_home.dart';
import 'package:provider/provider.dart';

class RecordHome extends StatefulWidget {
  @override
  _RecordHomeState createState() => _RecordHomeState();
}

class _RecordHomeState extends State<RecordHome> {
  @override
  Widget build(BuildContext context) {
    final UserData user = Provider.of(context);
    void showCreateItem() {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          context: context,
          builder: (maincontext) {
            return Container(
              color: Colors.grey[200],
              height: MediaQuery.of(context).size.height,
              child: CreateItemHome(
                user: user,
              ),
            );
          });
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            child: ItemList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        onPressed: () => showCreateItem(),
      ),
    );
  }
}
