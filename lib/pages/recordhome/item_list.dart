import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/user.dart';
import 'package:flutter_check_hub/pages/recordhome/item_tile.dart';
import 'package:provider/provider.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    final UserData userdata = Provider.of<UserData>(context) ?? UserData();
    //print(userdata.itemstitle.length);

    /*
    items.forEach((item) {
      print(item.date);
      print(item.data);
    });
    */

    return userdata?.itemstitle?.length == null
        ? const CupertinoActivityIndicator()
        : ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: userdata.itemstitle.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemTile(
                itemtitle: userdata.itemstitle[index],
                itemicon: userdata.itemsicon[index] ??
                    const CupertinoActivityIndicator(),
              );
            },
          );
  }
}
