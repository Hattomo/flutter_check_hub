import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/user.dart';
import 'package:flutter_check_hub/pages/recordhome/item_list.dart';
import 'package:flutter_check_hub/pages/setting/edit_item_home.dart';
import 'package:provider/provider.dart';

class RecordHome extends StatefulWidget {
  @override
  _RecordHomeState createState() => _RecordHomeState();
}

class _RecordHomeState extends State<RecordHome> {
  @override
  Widget build(BuildContext context) {
    final UserData user = Provider.of<UserData>(context);
    void showEditItem() {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          context: context,
          builder: (maincontext) {
            return Container(
              color: Colors.grey[200],
              height: MediaQuery.of(context).size.height,
              child: EditItemHome(
                user: user,
              ),
            );
          });
    }

    return Column(
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
                    Icons.delete_forever,
                  ),
                  onPressed: () => showEditItem(),
                ),
              ),
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
    );
  }
}
