import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_check_hub/models/user.dart';

class DatabaseServiceUser {
  DatabaseServiceUser({this.uid});
  final String uid;

  // collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future<void> updateuserData(
    String uid,
    List<String> itemsid,
    List<String> itemstitle,
    List<String> itemsicon,
  ) async {
    return await userCollection.document(uid).setData({
      'itemsid': itemsid,
      'itemstitle': itemstitle,
      'itemsicon': itemsicon,
      'uid': uid,
    });
  }

  Future<void> createuserData(String uid) async {
    return await userCollection.document(uid).setData({
      'itemsid': [],
      'itemstitle': [],
      'itemsicon': [],
      'uid': uid,
    });
  }

  Future<void> deleteuserData(User user) async {
    print(user.uid);
    return await userCollection.document(user.uid).delete();
  }

  Stream<UserData> user(User user) {
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
    try {
      return UserData(
        itemsid: List.from(snapshot.data['itemsid']) ?? [' '],
        itemstitle: List.from(snapshot.data['itemstitle']) ?? [' '],
        itemsicon: List.from(snapshot.data['itemsicon']) ?? [' '],
        uid: snapshot.data['uid'] ?? ' ',
      );
    } catch (e) {
      print(e);
    }
    return null;
  }
}
