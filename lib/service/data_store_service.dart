import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_check_hub/models/Item.dart';
import 'package:flutter_check_hub/service/user_dataservice.dart';

class DatabaseServiceItem {
  DatabaseServiceItem({this.itemid});
  final DatabaseServiceUser databaseServiceUser = DatabaseServiceUser();
  String itemid;
  // collection reference
  final CollectionReference itemCollection =
      Firestore.instance.collection('items');

  Future<void> updateItemData({
    @required String documentId,
    @required String uid,
    @required String title,
    @required String icon,
    @required String unit,
    @required int dataType,
    @required List<String> itemsid,
    @required List<String> itemstitle,
    @required List<String> itemsicon,
    @required List<String> itemsunit,
  }) async {
    await itemCollection.document(documentId).setData({
      'title': title,
      'icon': icon,
      'unit': unit,
      'dataType': dataType,
      'isInUse': true
    });
    for (int i = 0; i < itemsid.length; i++) {
      if (itemsid[i] == documentId) {
        itemstitle[i] = title;
        itemsicon[i] = icon;
        itemsunit[i] = unit;
      }
    }
    databaseServiceUser.updateuserData(
      uid,
      itemsid,
      itemstitle,
      itemsicon,
      itemsunit,
    );
  }

  Future<void> createItemData({
    @required String uid,
    @required String title,
    @required String icon,
    @required String unit,
    @required int dataType,
    @required List<String> itemsid,
    @required List<String> itemstitle,
    @required List<String> itemsicon,
    @required List<String> itemsunit,
  }) async {
    final String id = itemCollection.document().documentID;
    itemsid.add(id);
    itemstitle.add(title);
    itemsicon.add(icon);
    itemsunit.add(unit);
    await itemCollection.document(id).setData({
      'title': title,
      'icon': icon,
      'unit': unit,
      'dataType': dataType,
      'isInUse': true
    });
    databaseServiceUser.updateuserData(
      uid,
      itemsid,
      itemstitle,
      itemsicon,
      itemsunit,
    );
  }

  Future<void> deleteItemData({
    @required String itemid,
    @required String uid,
    @required List<String> itemsid,
    @required List<String> itemstitle,
    @required List<String> itemsicon,
    @required List<String> itemsunit,
  }) async {
    //print(item.title);
    await itemCollection.document(itemid).setData({
      'isInUse': false,
    });
    for (int i = 0; i < itemsid.length; i++) {
      if (itemsid[i] == itemid) {
        itemsid.removeAt(i);
        itemstitle.removeAt(i);
        itemsicon.removeAt(i);
        itemsunit.removeAt(i);
      }
    }
    databaseServiceUser.updateuserData(
        uid, itemsid, itemstitle, itemsicon, itemsunit);
  }

  // itemmodels list from snapshot
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return Item(
          title: doc.data['title'] ?? '',
          icon: doc.data['icon'] ?? '',
          unit: doc.data['unit'] ?? '',
          dataType: doc.data['dataType'] ?? -100);
    }).toList();
  }

  //user data from snapshot
  ItemData _itemDataFromSnapshot(DocumentSnapshot snapshot) {
    return ItemData(
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
        .snapshots()
        .map(_itemDataFromSnapshot);
  }

  Future<void> createItemDailyData(
      String itemId, String documentId, var data, DateTime dateTime) async {
    final int date = dateTime.difference(DateTime(2020, 1, 1)).inDays;
    await itemCollection
        .document(itemId)
        .collection('data')
        .document(documentId)
        .setData({
      'data': data,
      'documentId': documentId,
      'datadate': date,
    });
  }

  Future<void> updateItemDailyData(
      String itemId, String documentId, var data, DateTime dateTime) async {
    final int date = dateTime.difference(DateTime(2020, 1, 1)).inDays;
    await itemCollection
        .document(itemId)
        .collection('data')
        .document(documentId)
        .setData({
      'data': data,
      'documentId': documentId,
      'datadate': date,
    });
  }

  Future<void> deleteItemDailyData(String itemId, String documentId) async {
    await itemCollection
        .document(itemId)
        .collection('data')
        .document(documentId)
        .delete();
  }

  Future<dynamic> readItemDailyData(String itemId, String documentId) async {
    try {
      return await Firestore.instance
          .collection('items/' + itemId + '/data')
          .document(documentId)
          .get(source: Source.serverAndCache)
          .then((snapshot) {
        if (snapshot.exists) {
          //print('data: ${value.data}');
          return snapshot.data['data'];
        }
      });
    } catch (e) {
      return 'NetWorkError';
    }
  }

  Future<List<dynamic>> getListItemdata(String itemId) async {
    final int date = DateTime.now().difference(DateTime(2020, 1, 1)).inDays;
    final QuerySnapshot data = await Firestore.instance
        .collection('items/' + itemId + '/data')
        .where('datadate', isLessThanOrEqualTo: date)
        .where('datadate', isGreaterThan: date - 30)
        .orderBy('datadate')
        .getDocuments();
    final List<dynamic> list = [];
    for (int i = 0; i < data.documents.length; i++) {
      final List<dynamic> docdata = [
        data.documents[i].data['data'],
        data.documents[i].data['documentId'],
        data.documents[i].data['datadate'],
      ];
      list.add(docdata);
    }
    print(list);
    return list;
  }
}
