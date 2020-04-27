import 'package:flutter/material.dart';

void main() {
  runApp(CheckHub());
}

class CheckHub extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CheckHub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CheckHubHome(),
    );
  }
}

class CheckHubHome extends StatefulWidget {
  @override
  _CheckHubHomeState createState() => _CheckHubHomeState();
}

class _CheckHubHomeState extends State<CheckHubHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CheckHub'),
      ),
      body: Center(
        child: Text('Hello! CheckHub'),
      ),
    );
  }
}
