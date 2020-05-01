import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_check_hub/models/user.dart';

class DatabaseServiceUser {
  DatabaseServiceUser({this.titles});
  final String titles;

  // collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future<void> updateuserData(String uid, var name) async {
    return await userCollection.document(uid).setData({
      'name': name,
    });
  }

  Future<void> createuserData(var name) async {
    return await userCollection.document().setData({
      'name': name,
    });
  }

  Future<void> deleteuserData(User user) async {
    print(user.uid);
    return await userCollection.document(user.uid).delete();
  }

  Stream<User> user(User user) {
    return userCollection.document(user.uid).snapshots().map((doc) {
      return User(
        name: doc.data['name'] ?? '',
      );
    });
  }
}
