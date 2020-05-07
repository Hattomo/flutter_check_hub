import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/Item.dart';
import 'package:flutter_check_hub/models/user.dart';
import 'package:flutter_check_hub/pages/recordhome/item_list.dart';
import 'package:flutter_check_hub/pages/setting/edit_item_home.dart';
import 'package:flutter_check_hub/service/data_store_service.dart';
import 'package:provider/provider.dart';

class RecordHome extends StatefulWidget {
  @override
  _RecordHomeState createState() => _RecordHomeState();
}

class _RecordHomeState extends State<RecordHome> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    print('ee${user.uid}');
    void showEditItem() {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
          context: context,
          builder: (context) {
            return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                    borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0))),
              height: MediaQuery.of(context).size.height*(3/4),
              child: EditItemHome(user: user),
            );
          });
    }

    return StreamProvider<List<Item>>.value(
      value: DatabaseServiceItem().items,
      child: Column(
        children: [
          Container(
            color: Colors.grey[200],
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit,
                    ),
                    onPressed: () => showEditItem(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.share,
                    ),
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
          Container(
            child: ItemList(),
          ),
        ],
      ),
    );
  }
}
