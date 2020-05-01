import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/user.dart';
import 'package:flutter_check_hub/pages/auth/authenticate.dart';
import 'package:flutter_check_hub/pages/home.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //print('user:$user');
    // return either the plan or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return CheckHubHome();
    }
  }
}
