import 'package:flutter/material.dart';
import 'package:flutter_check_hub/service/database.dart';

class ManageItemHome extends StatefulWidget {
  @override
  _ManageItemHomeState createState() => _ManageItemHomeState();
}

class _ManageItemHomeState extends State<ManageItemHome> {
  final DatabaseOperater databaseOperater = DatabaseOperater(DatabaseFactory());

  @override
  Widget build(BuildContext context) {
    final Future<dynamic> data = databaseOperater.fecth('おおお');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Items'),
      ),
      body: FutureBuilder<dynamic>(
        future: data,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error Occur');
            }
            if (!snapshot.hasData) {
              return const Center(child: Text('Let\'s add Item!'));
            }
            return ListTile(
              title: Text(
                '${snapshot.data.tablename}',
              ),
              subtitle: Text('${snapshot.data.dataType}'),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
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
