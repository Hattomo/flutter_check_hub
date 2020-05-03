import 'package:flutter/material.dart';
import 'package:flutter_check_hub/pages/auth/auth_home.dart';
import 'package:flutter_check_hub/pages/home.dart';
import 'package:flutter_check_hub/pages/setting/data_type_setting.dart';
import 'package:flutter_check_hub/pages/setting/edit_item_home_wrapper.dart';
import 'package:flutter_check_hub/pages/setting/manage_item_home.dart';
import 'package:flutter_check_hub/pages/setting/repeat_setting.dart';

void main() => runApp(CheckHub());

class CheckHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CheckHub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/':(BuildContext context)=>AuthHome(),
        '/checkHubHome': (BuildContext context) => CheckHubHome(),
        '/manageItemHome': (BuildContext context) => ManageItemHome(),
        '/editItemHomeWrapper': (BuildContext context) => EditItemHomeWrapper(),
        '/dataTypeSetting': (BuildContext context) => DataTypeSetting(),
        '/repeatSetting': (BuildContext context) => RepeatSetting()
      },
    );
  }
}
