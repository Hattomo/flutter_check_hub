import 'package:flutter/material.dart';
import 'package:flutter_check_hub/service/database.dart';
import 'package:flutter_check_hub/shared/text_input_decoration.dart';

class EditItemHome extends StatefulWidget {
  @override
  _EditItemHomeState createState() => _EditItemHomeState();
}

class _EditItemHomeState extends State<EditItemHome> {
  String currenttitle;
  String currentunit;
  final DatabaseOperater _databaseOperater=DatabaseOperater(DatabaseFactory());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void showIconSetting() {
      showModalBottomSheet<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300.0,
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Item'),
        leading: FlatButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Done'),
            onPressed: () async {
              await _databaseOperater.save(0,'ttt');
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            ListTile(
                title: TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Title 🚀'),
              validator: (String val) =>
                  val.isEmpty ? 'Please enter a title' : null,
              onChanged: (String val) => setState(() => currenttitle = val),
            )),
            ListTile(
              title: const Text('Data Type'),
              leading: const Icon(Icons.style),
              trailing: const Icon(Icons.arrow_forward_ios),
              subtitle: const Text('current data type'),
              onTap: () => Navigator.pushNamed(context, '/dataTypeSetting'),
            ),
            ListTile(
                title: TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Unit 🐣'),
              validator: (String val) =>
                  val.isEmpty ? 'Please enter a title' : null,
              onChanged: (String val) => setState(() => currenttitle = val),
            )),
            ListTile(
              leading: const Icon(Icons.insert_emoticon),
              title: const Text('Icon'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => showIconSetting(),
            ),
            ListTile(
              leading: const Icon(Icons.repeat),
              title: const Text('Repeat'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.pushNamed(context, '/repeatSetting'),
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notification'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.iso),
              title: const Text('Goal'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
