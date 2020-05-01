import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/Item.dart';

class ItemTile extends StatefulWidget {
  const ItemTile({this.item});
  final Item item;
  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          child: Text('&&'),
          backgroundColor: Colors.blue,
        ),
        title: Text('###'),
      ),
    );
  }
}
