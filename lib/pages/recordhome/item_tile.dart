import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/user.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatefulWidget {
  const ItemTile({this.itemtitle, this.itemicon});
  final String itemtitle;
  final String itemicon;
  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    final UserData user = Provider.of(context);
    print(user.itemsid);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(widget.itemicon),
          backgroundColor: Colors.blue,
        ),
        title: Text(widget.itemtitle),
        trailing: const Icon(Icons.edit),
        onTap: () => null,
      ),
    );
  }
}
