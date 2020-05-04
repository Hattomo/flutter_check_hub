import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_check_hub/models/user.dart';

class DatabaseServiceUser {
  DatabaseServiceUser({this.uid});
  final String uid;

  // collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future<void> updateuserData(String uid, List<String> itemid) async {
    return await userCollection
        .document(uid)
        .setData({'itemsid': itemid, 'name': 'yy', uid: uid});
  }

  Future<void> createuserData(String uid) async {
    return await userCollection.document(uid).setData({
      'itemsid': [],
    });
  }

  Future<void> deleteuserData(User user) async {
    print(user.uid);
    return await userCollection.document(user.uid).delete();
  }

  Stream<UserData> user(User user) {
    print('&&&&&');
    try {
      return userCollection
          .document(user.uid)
          .snapshots()
          .map(_userDataFromSnapshot);
    } catch (e) {
      print(e);
    }
    return null;
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    print(snapshot.data['itemsid']);
    print(snapshot.data['uid']);
    try {
      return UserData(
          itemsid: List.from(snapshot.data['itemsid']) ?? [' '],
          uid: snapshot.data['uid'] ?? ' ',
          name: snapshot.data['name'] ?? ' ');
    } catch (e) {
      print(e);
    }
    return null;
  }
}
