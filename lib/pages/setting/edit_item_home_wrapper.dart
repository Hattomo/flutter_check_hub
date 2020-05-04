import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/user.dart';
import 'package:flutter_check_hub/pages/setting/edit_item_home.dart';
import 'package:flutter_check_hub/service/auth_service.dart';
import 'package:flutter_check_hub/service/user_dataservice.dart';
import 'package:provider/provider.dart';

class EditItemHomeWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(AuthService().user);

    return StreamProvider<User>.value(
      initialData: User(itemsid: [], uid: ' ', name: ' '),
      catchError: (_, err) => User(itemsid: [], uid: ' ', name: ' '),
      value: AuthService().user,
      child: Container(child: EditHomeUserData()),
    );
  }
}

class EditHomeUserData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of(context);
    print('rr+${user.uid}');
    return StreamProvider<UserData>.value(
      initialData: UserData(itemsid: [], uid: ' ', name: ' '),
      catchError: (_, err) => UserData(itemsid: [], uid: ' ', name: ' '),
      value: DatabaseServiceUser().user(user),
      child: Container(child: EditItemHome()),
    );
  }
}
