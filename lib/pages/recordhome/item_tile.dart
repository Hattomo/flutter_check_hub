import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_check_hub/service/data_store_service.dart';
import 'package:flutter_check_hub/service/datebase_key.dart';
import 'package:flutter_check_hub/shared/text_input_decoration.dart';
import 'package:provider/provider.dart';

@immutable
class ItemTile extends StatefulWidget {
  const ItemTile({this.itemId, this.itemtitle, this.itemicon});
  final String itemtitle;
  final String itemicon;
  final String itemId;
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
                                widget.itemId,
                                databaseKey.datetimetKeyFormatter(dateTime),
                                currentdata);
                            setState(() {
                              
                            });
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
    //final UserData user = Provider.of(context);
    final DateTime dateTime = Provider.of(context);
    String itemTextData;
    return FutureBuilder(
      future: databaseServiceItem.readItemDailyData(
          widget.itemId, databaseKey.datetimetKeyFormatter(dateTime)),
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
                child: Text(widget.itemicon),
                backgroundColor: Colors.blue,
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.itemtitle,
                    style: const TextStyle(fontSize: 13.0),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(itemTextData),
                ],
              ),
              trailing: Text(dateTime.toString()),
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
