import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_check_hub/pages/auth/auth_home.dart';
import 'package:flutter_check_hub/pages/home.dart';
import 'package:flutter_check_hub/pages/setting/itemsetting/data_type_setting.dart';
import 'package:flutter_check_hub/pages/setting/itemsetting/repeat_setting.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setEnabledSystemUIOverlays([]);
  await Firebase.initializeApp();
  runApp(CheckHub());
}

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
        '/': (BuildContext context) => AuthHome(),
        '/checkHubHome': (BuildContext context) => CheckHubHome(),
        '/dataTypeSetting': (BuildContext context) => DataTypeSetting(),
        '/repeatSetting': (BuildContext context) => RepeatSetting()
      },
    );
  }
}
