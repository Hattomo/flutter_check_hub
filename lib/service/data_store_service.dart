import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_check_hub/models/Item.dart';
import 'package:flutter_check_hub/service/user_dataservice.dart';

class DatabaseServiceItem {
  DatabaseServiceItem({this.date});
  final databaseServiceUser = DatabaseServiceUser();
  int idLength = 20;
  final String date;

  // collection reference
  final CollectionReference itemCollection =
      Firestore.instance.collection('items');

  Future<void> updateItemData(String uid, String date, var data) async {
    return await itemCollection.document(uid).setData({
      'date': date,
      'data': data,
    });
  }

  Future<void> createItemData(String uid, String date, var data) async {
    final String id = itemCollection.document().documentID;
    print(id);
    await itemCollection.document(id).setData({'date': date, 'data': data});
    databaseServiceUser.updateuserData(id);
  }

  Future<void> deleteItemData(Item item) async {
    print(item.date);
    return await itemCollection.document(item.date).delete();
  }

  // itemmodels list from snapshot
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return Item(
        data: doc.data['data'] ?? '',
        date: doc.data['date'] ?? '',
      );
    }).toList();
  }

  //user data from snapshot
  ItemData _itemDataFromSnapshot(DocumentSnapshot snapshot) {
    return ItemData(
      data: snapshot.data['data'],
      date: snapshot.data['date'],
    );
  }

  // get itemmodels stream

  Stream<List<Item>> get items {
    return itemCollection
        //      .orderBy("data", descending: true)
        .snapshots()
        .map(_itemListFromSnapshot);
  }

  //get user doc stream
  Stream<ItemData> get itemData {
    return itemCollection.document(date).snapshots().map(_itemDataFromSnapshot);
  }
}
