import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/Item.dart';
import 'package:flutter_check_hub/pages/recordhome/item_tile.dart';
import 'package:provider/provider.dart';


class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    final List<Item> items = Provider.of<List<Item>>(context) ?? [];
    print(items.length);

    /*
    items.forEach((item) {
      print(item.date);
      print(item.data);
    });
    */

    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return ItemTile(item: items[index]);
      },
    );
  }
}