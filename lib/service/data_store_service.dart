import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_check_hub/models/Item.dart';
import 'package:flutter_check_hub/service/user_dataservice.dart';

class DatabaseServiceItem {
  DatabaseServiceItem({this.itemid});
  final DatabaseServiceUser databaseServiceUser = DatabaseServiceUser();
  //await itemCollection.document(id).collection('data').document(date).setData({'date': date, 'data': data});
  String itemid;
  // collection reference
  final CollectionReference itemCollection =
      Firestore.instance.collection('items');

  Future<void> updateItemData(
      {String id,
      String title,
      var data,
      String icon,
      String unit,
      int dataType}) async {
    return await itemCollection.document(id).setData({
      'title': title,
      'data': data,
      'icon': icon,
      'unit': unit,
      'dataType': dataType
    });
  }

  Future<void> createItemData(
    String uid,
    String title,
    var data,
    String icon,
    String unit,
    int dataType,
    List<String> itemsid,
    List<String> itemstitle,
    List<String> itemsicon,
  ) async {
    final String id = itemCollection.document().documentID;
    itemsid.add(id);
    itemstitle.add(title);
    itemsicon.add(icon);
    await itemCollection.document(id).setData({
      'title': title,
      'data': data,
      'icon': icon,
      'unit': unit,
      'dataType': dataType
    });
    databaseServiceUser.updateuserData(
      uid,
      itemsid,
      itemstitle,
      itemsicon,
    );
  }

  Future<void> deleteItemData(String itemid) async {
    //print(item.title);
    return await itemCollection.document(itemid).delete();
  }

  // itemmodels list from snapshot
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return Item(
          data: doc.data['data'] ?? '',
          title: doc.data['title'] ?? '',
          icon: doc.data['icon'] ?? '',
          unit: doc.data['unit'] ?? '',
          dataType: doc.data['dataType'] ?? -100);
    }).toList();
  }

  //user data from snapshot
  ItemData _itemDataFromSnapshot(DocumentSnapshot snapshot) {
    return ItemData(
      data: snapshot.data['data'],
      title: snapshot.data['title'],
      icon: snapshot.data['icon'] ?? '',
      unit: snapshot.data['unit'] ?? '',
      dataType: snapshot.data['dataType'] ?? '',
    );
  }

  // get itemmodels stream

  Stream<List<Item>> get items {
    try {
      return itemCollection
          //.getDocuments(source:Source.cache)
          //      .orderBy("data", descending: true)
          .snapshots()
          .map(_itemListFromSnapshot);
    } catch (e) {
      print(e);
    }
    return null;
  }

  //get user doc stream
  Stream<ItemData> get itemData {
    return itemCollection
        .document(itemid)
        //.get(source: Source.cache)
        .snapshots()
        .map(_itemDataFromSnapshot);
  }
}
