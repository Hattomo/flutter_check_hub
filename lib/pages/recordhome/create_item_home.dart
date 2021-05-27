import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/Item.dart';
import 'package:flutter_check_hub/models/user.dart';
import 'package:flutter_check_hub/pages/setting/itemsetting/data_type_setting.dart';
import 'package:flutter_check_hub/service/data_store_service.dart';
import 'package:flutter_check_hub/shared/text_input_decoration.dart';

@immutable
class CreateItemHome extends StatefulWidget {
  const CreateItemHome({Key key, this.user}) : super(key: key);
  final User user;
  @override
  _CreateItemHomeState createState() => _CreateItemHomeState();
}

class _CreateItemHomeState extends State<CreateItemHome> {
  String currenttitle;
  String currentunit;
  String currentgoal;
  String currenticon;
  String currentdataType;
  int currentrepeatsetting;

  final DatabaseServiceItem dataServiceItem = DatabaseServiceItem();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //print(widget.user);
    //print('user uid: ${widget.user.uid}');
    //print('user itemsid: ${widget.user.itemsid}');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Create Item'),
        actions: [
          TextButton(
            child: const Text('Done'),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                dataServiceItem.createItemData(
                  user: User(
                    uid: widget.user.uid,
                    itemsid: widget.user.itemsid,
                    itemstitle: widget.user.itemstitle,
                    itemsicon: widget.user.itemsicon,
                    itemsunit: widget.user.itemsunit,
                    itemsdataType: widget.user.itemsdataType,
                  ),
                  item: Item(
                    title: currenttitle,
                    icon: currenticon,
                    unit: currentunit,
                    dataType: 'Number',
                  ),
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
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
              const SizedBox(
                height: 20.0,
              ),
              Container(
                color: Colors.white,
                child: ListTile(
                    title: const Text('Data Type'),
                    leading: const Icon(Icons.style),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    subtitle: currentdataType == null
                        ? const Text('choose data type')
                        : Text(currentdataType),
                    onTap: () async {
                      currentdataType = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DataTypeSetting();
                      }));
                      print('currentdataType: $currentdataType');
                      setState(() => null);
                    }),
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
                        val.isEmpty ? 'Please enter a goal' : null,
                    onChanged: (String val) =>
                        setState(() => currentgoal = val),
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
