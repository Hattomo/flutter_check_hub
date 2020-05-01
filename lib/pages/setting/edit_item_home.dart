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
  String currentgoal;
  String currenticon;
  final DatabaseOperater _databaseOperater =
      DatabaseOperater(DatabaseFactory());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Item'),
        leading: FlatButton(
          child: const Icon(Icons.cancel),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Done'),
            onPressed: () async {
              await _databaseOperater.save(10, currenttitle);
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,        
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20.0,),
            ListTile(
              title: TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Title 🚀'),
                validator: (String val) =>
                    val.isEmpty ? 'Please enter a title' : null,
                onChanged: (String val) => setState(() => currenttitle = val),
              ),
              leading: const Icon(Icons.title),
            ),
            ListTile(
              title: const Text('Data Type'),
              leading: const Icon(Icons.style),
              trailing: const Icon(Icons.arrow_forward_ios),
              subtitle: const Text('current data type'),
              onTap: () => Navigator.pushNamed(context, '/dataTypeSetting'),
            ),
            ListTile(
                leading: const Icon(Icons.ac_unit),
                title: TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Unit 🐣'),
                  validator: (String val) =>
                      val.isEmpty ? 'Please enter a title' : null,
                  onChanged: (String val) => setState(() => currentunit = val),
                )),
            ListTile(
              leading: const Icon(Icons.insert_emoticon),
              title: TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Please input one emoji 😀'),
                validator: (String val) =>
                    val.isEmpty ? 'Please enter a title' : null,
                onChanged: (String val) => setState(() => currenticon = val),
              ),
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
              title: TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Please input goal 🎉'),
                validator: (String val) =>
                    val.isEmpty ? 'Please enter a title' : null,
                onChanged: (String val) => setState(() => currentgoal = val),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
