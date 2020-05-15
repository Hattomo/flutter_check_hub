import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/Item.dart';
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
        ? Container(
            height: 100.0,
            child: const Center(child: CupertinoActivityIndicator()))
        : ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: userdata.itemstitle.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemTile(
                  itemdata: ItemData(
                title: userdata.itemstitle[index],
                icon: userdata.itemsicon[index],
                id: userdata.itemsid[index],
                unit: userdata.itemsunit[index],
              ));
            },
          );
  }
}
