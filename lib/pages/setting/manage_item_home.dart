import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/Item.dart';
import 'package:flutter_check_hub/pages/recordhome/item_list.dart';
import 'package:flutter_check_hub/service/data_store_service.dart';
import 'package:flutter_check_hub/service/database.dart';
import 'package:provider/provider.dart';

class ManageItemHome extends StatefulWidget {
  @override
  _ManageItemHomeState createState() => _ManageItemHomeState();
}

class _ManageItemHomeState extends State<ManageItemHome> {
  final DatabaseOperater databaseOperater = DatabaseOperater(DatabaseFactory());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Items'),
      ),
      body: StreamProvider<List<Item>>.value(
        value: DatabaseServiceItem().items,
        child: Container(
          child:ItemList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        onPressed: () => Navigator.pushNamed(context, '/editItemHomeWrapper'),
      ),
    );
  }
}
