import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/user.dart';
import 'package:flutter_check_hub/pages/auth/auth_wrapper.dart';
import 'package:flutter_check_hub/service/auth_service.dart';
import 'package:provider/provider.dart';

class AuthHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamProvider<User>.value(
        value: AuthService().user,
        child: Container(
          child: AuthWrapper(),
        ),
      ),
    );
  }
}
