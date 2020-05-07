import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/user.dart';
import 'package:flutter_check_hub/service/data_store_service.dart';
import 'package:flutter_check_hub/shared/text_input_decoration.dart';

class EditItemHome extends StatefulWidget {
  EditItemHome({Key key, this.user}) : super(key: key);
  User user;
  @override
  _EditItemHomeState createState() => _EditItemHomeState();
}

class _EditItemHomeState extends State<EditItemHome> {
  String currenttitle;
  String currentunit;
  String currentgoal;
  String currenticon;

  final DatabaseServiceItem dataServiceItem = DatabaseServiceItem();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(widget.user);
    print(widget.user.uid);
    print(widget.user.name);
    print(widget.user.itemsid);
    return Column(
        children: [
          Container(
            decoration: BoxDecoration(
                  color: Colors.white,
                    borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.cancel,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text('Create Item'),
                IconButton(
                  icon: const Icon(Icons.done),
                  onPressed: () async {
              await dataServiceItem.createItemData(
                  uid: widget.user.uid, title: 'walk', data: 'yy');
            },
                )
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  color: Colors.white,
                  child: ListTile(
                    title: TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Title 🚀'),
                      validator: (String val) =>
                          val.isEmpty ? 'Please enter a title' : null,
                      onChanged: (String val) =>
                          setState(() => currenttitle = val),
                    ),
                    leading: const Icon(Icons.title),
                  ),
                ),
                const SizedBox(height: 20.0,),
                Container(
                  color: Colors.white,
                  child: ListTile(
                    title: const Text('Data Type'),
                    leading: const Icon(Icons.style),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    subtitle: const Text('current data type'),
                    onTap: () => Navigator.pushNamed(context, '/dataTypeSetting'),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: ListTile(
                      leading: const Icon(Icons.ac_unit),
                      title: TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Unit 🐣'),
                        validator: (String val) =>
                            val.isEmpty ? 'Please enter a title' : null,
                        onChanged: (String val) =>
                            setState(() => currentunit = val),
                      )),
                ),
                Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: const Icon(Icons.insert_emoticon),
                    title: TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Please input one emoji 😀'),
                      validator: (String val) =>
                          val.isEmpty ? 'Please enter a title' : null,
                      onChanged: (String val) =>
                          setState(() => currenticon = val),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: const Icon(Icons.repeat),
                    title: const Text('Repeat'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => Navigator.pushNamed(context, '/repeatSetting'),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text('Notification'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: const Icon(Icons.iso),
                    title: TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Please input goal 🎉'),
                      validator: (String val) =>
                          val.isEmpty ? 'Please enter a title' : null,
                      onChanged: (String val) =>
                          setState(() => currentgoal = val),
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
    );
  }
}
