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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const CircleAvatar(
          child: Text('ttt'),
          backgroundColor: Colors.blue,
        ),
        title: const Text('###'),
        trailing: const Icon(Icons.edit),
        onTap: () => null,
      ),
    );
  }
}
