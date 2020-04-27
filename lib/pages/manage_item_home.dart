import 'package:flutter/material.dart';

class ManageItemHome extends StatefulWidget {
  @override
  _ManageItemHomeState createState() => _ManageItemHomeState();
}

class _ManageItemHomeState extends State<ManageItemHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Items'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        onPressed: () => Navigator.pushNamed(context, '/editItemHome'),
      ),
    );
  }
}
