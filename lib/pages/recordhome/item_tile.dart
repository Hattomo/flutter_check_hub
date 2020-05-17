import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/Item.dart';
import 'package:flutter_check_hub/models/user.dart';
import 'package:flutter_check_hub/pages/graph/listview_data.dart';
import 'package:flutter_check_hub/pages/recordhome/edit_item_home.dart';
import 'package:flutter_check_hub/service/data_store_service.dart';
import 'package:flutter_check_hub/service/datebase_key.dart';
import 'package:flutter_check_hub/shared/text_input_decoration.dart';
import 'package:provider/provider.dart';

@immutable
class ItemTile extends StatefulWidget {
  const ItemTile({this.itemdata});
  final Item itemdata;
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 8.0, left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Input number',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
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
                  ButtonBar(
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

  void showTimeDialog(DateTime dateTime) {
    showDialog(
        context: context,
        builder: (builder) {
          Duration currenttime;
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: CupertinoTheme(
              data: const CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                      pickerTextStyle: TextStyle(color: Colors.blue))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Input Date'),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CupertinoTimerPicker(
                      mode: CupertinoTimerPickerMode.hms,
                      onTimerDurationChanged: (val) => currenttime = val,
                    ),
                  ),
                  ButtonBar(
                    children: [
                      FlatButton(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      FlatButton(
                        child: const Text('Done'),
                        onPressed: () {
                          databaseServiceItem.createItemDailyData(
                            widget.itemdata.id,
                            databaseKey.datetimetKeyFormatter(dateTime),
                            '${currenttime.inHours.toString().padLeft(2, '0')}:${(currenttime.inMinutes % 60).toString().padLeft(2, '0')}:${(currenttime.inSeconds % 60).toString().padLeft(2, '0')}',
                            dateTime,
                          );
                          setState(() {});
                          Navigator.pop(context);
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

  void showStringDialog(DateTime dateTime) {
    final _formKey = GlobalKey<FormState>();
    String _currentdata;
    showDialog(
        context: context,
        builder: (builder) {
          return Dialog(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Input'),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 3,
                      maxLines: null,
                      textAlign: TextAlign.start,
                      decoration: textInputDecoration.copyWith(),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter text' : null,
                      onChanged: (val) => setState(() => _currentdata = val),
                    ),
                  ),
                ),
                ButtonBar(
                  children: [
                    FlatButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: const Text('Done'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          databaseServiceItem.createItemDailyData(
                            widget.itemdata.id,
                            databaseKey.datetimetKeyFormatter(dateTime),
                            _currentdata.toString(),
                            dateTime,
                          );
                          setState(() {});
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of(context);
    void showEditItem() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return EditItemHome(
              user: user,
              itemdata: widget.itemdata,
            );
          },
          fullscreenDialog: true,
        ),
      );
    }

    void showDeleteDailog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, left: 8.0, right: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Do you really want to delete this ?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ButtonBar(
                      children: [
                        FlatButton(
                            child: const Text('Cancel'),
                            onPressed: () => Navigator.pop(context)),
                        FlatButton(
                          child: const Text('Delete'),
                          textColor: Colors.red,
                          onPressed: () {
                            databaseServiceItem.deleteItemData(
                              user: User(
                                uid: user.uid,
                                itemsid: user.itemsid,
                                itemstitle: user.itemstitle,
                                itemsicon: user.itemsicon,
                                itemsunit: user.itemsunit,
                              ),
                              item: Item(id: widget.itemdata.id),
                            );
                            CloudFunctions(region: 'asia-northeast1')
                                .getHttpsCallable(
                                    functionName: 'recursivedeleteitemdata')
                                .call(<String, dynamic>{
                              'documentId': widget.itemdata.id,
                            });
                            Navigator.pop(context);
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

    final DateTime dateTime = Provider.of(context);
    dynamic itemTextData;
    return FutureBuilder(
      future: databaseServiceItem.readItemDailyData(
          widget.itemdata.id, databaseKey.datetimetKeyFormatter(dateTime)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            itemTextData = 'Error Occur! Retry Later';
          }
          if (!snapshot.hasData) {
            itemTextData = 'No Data Avaiable';
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
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13.0,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    if (itemTextData == 'No Data Avaiable')
                      Text(
                        itemTextData,
                        style: const TextStyle(color: Colors.grey),
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              itemTextData,
                              //overflow: TextOverflow.ellipsis,
                              style: widget.itemdata.dataType == 'Text'
                                  ? const TextStyle(fontSize: 11.0)
                                  : const TextStyle(fontSize: 20.0),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            widget.itemdata.unit,
                            //overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                  ],
                ),
                trailing: PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            const Icon(Icons.list),
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Text('List'),
                          ],
                        ),
                        value: 0,
                      ),
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
                        value: 1,
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
                        value: 2,
                      ),
                    ];
                  },
                  onSelected: (val) {
                    if (val == 0) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (content) {
                              return DataListView(
                                item: widget.itemdata,
                              );
                            }),
                      );
                    } else if (val == 1) {
                      showEditItem();
                    } else if (val == 2) {
                      showDeleteDailog();
                    }
                  },
                ),
                //onTap: () => showNumberDialog(dateTime),
                onTap: () {
                  print(widget.itemdata.dataType);
                  if (widget.itemdata.dataType == 'Number') {
                    return showNumberDialog(dateTime);
                  } else if (widget.itemdata.dataType == 'Text') {
                    return showStringDialog(dateTime);
                  } else if (widget.itemdata.dataType == 'Time') {
                    return showTimeDialog(dateTime);
                  }
                }),
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
