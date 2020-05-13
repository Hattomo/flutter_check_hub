import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/Item.dart';
import 'package:flutter_check_hub/models/user.dart';
import 'package:flutter_check_hub/pages/setting/edit_item_home.dart';
import 'package:flutter_check_hub/service/data_store_service.dart';
import 'package:flutter_check_hub/service/datebase_key.dart';
import 'package:flutter_check_hub/shared/text_input_decoration.dart';
import 'package:provider/provider.dart';

@immutable
class ItemTile extends StatefulWidget {
  const ItemTile({this.itemdata});
  final ItemData itemdata;
  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseServiceItem databaseServiceItem = DatabaseServiceItem();
  DatabaseKey databaseKey = DatabaseKey();
  bool _isAutovalidate = false;

  void showNumberDialog(DateTime dateTime) {
    String currentdata;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Input number'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Form(
                    key: _formKey,
                    onChanged: () {
                      final isAutovalidate = _formKey.currentState.validate();
                      if (_isAutovalidate != isAutovalidate) {
                        setState(() {
                          _isAutovalidate = isAutovalidate;
                        });
                      }
                    },
                    child: TextFormField(
                      autovalidate: _isAutovalidate,
                      keyboardType: TextInputType.number,
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Input number'),
                      validator: (value) {
                        final double isDigitsOnly = double.tryParse(value);
                        return isDigitsOnly == null
                            ? 'Input needs to be digits only'
                            : null;
                      },
                      onChanged: (value) => setState(() => currentdata = value),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      FlatButton(
                        child: const Text('Done'),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            databaseServiceItem.createItemDailyData(
                              widget.itemdata.id,
                              databaseKey.datetimetKeyFormatter(dateTime),
                              currentdata,
                              dateTime,
                            );
                            setState(() {});
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final UserData user = Provider.of(context);
    void showEditItem() {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          context: context,
          builder: (maincontext) {
            return Provider.value(
              value: widget.itemdata,
              child: Container(
                color: Colors.grey[200],
                height: MediaQuery.of(context).size.height,
                child: EditItemHome(
                  user: user,
                  itemid: widget.itemdata.id,
                ),
              ),
            );
          });
    }

    void showDeleteDailog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Do you really want to delete this ?'),
                  ButtonBar(
                    children: [
                      FlatButton(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.pop(context)),
                      FlatButton(
                        child: const Text('Delete'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
    }

    final DateTime dateTime = Provider.of(context);
    String itemTextData;
    return FutureBuilder(
      future: databaseServiceItem.readItemDailyData(
          widget.itemdata.id, databaseKey.datetimetKeyFormatter(dateTime)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            itemTextData = 'Error Occur! Retry Later';
          }
          if (!snapshot.hasData) {
            itemTextData = 'No Data Available';
          }
          if (snapshot.hasData) {
            itemTextData = snapshot.data;
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(widget.itemdata.icon),
                backgroundColor: Colors.blue,
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.itemdata.title,
                    style: const TextStyle(fontSize: 13.0),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(itemTextData),
                ],
              ),
              trailing: PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          const Icon(Icons.edit),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text('Edit'),
                        ],
                      ),
                      value: 0,
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          const Icon(Icons.delete_forever),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text('Delete')
                        ],
                      ),
                      value: 1,
                    ),
                  ];
                },
                onSelected: (val) {
                  if (val == 0) {
                    showEditItem();
                  } else if (val == 1) {
                    showDeleteDailog();
                  }
                },
              ),
              onTap: () => showNumberDialog(dateTime),
            ),
          );
        } else {
          return Container(
              height: 100.0,
              child: const Center(child: CupertinoActivityIndicator()));
        }
      },
    );
  }
}
