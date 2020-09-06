import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_check_hub/models/Item.dart';
import 'package:flutter_check_hub/models/user.dart';
import 'package:flutter_check_hub/service/user_dataservice.dart';

class DatabaseServiceItem {
  DatabaseServiceItem({this.itemid});
  final DatabaseServiceUser databaseServiceUser = DatabaseServiceUser();
  String itemid;
  // collection reference
  final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('items');

  Future<void> updateItemData({
    @required User user,
    @required Item item,
  }) async {
    await itemCollection.doc(item.id).set({
      'title': item.title,
      'icon': item.icon,
      'unit': item.unit,
      'dataType': item.dataType,
      'id': item.id,
      'isInUse': true,
    });
    for (int i = 0; i < user.itemsid.length; i++) {
      if (user.itemsid[i] == item.id) {
        user.itemstitle[i] = item.title;
        user.itemsicon[i] = item.icon;
        user.itemsunit[i] = item.unit;
        user.itemsdataType[i] = item.dataType;
      }
    }
    databaseServiceUser.updateuserData(
      user.uid,
      user.itemsid,
      user.itemstitle,
      user.itemsicon,
      user.itemsunit,
      user.itemsdataType,
    );
  }

  Future<void> createItemData({
    @required User user,
    @required Item item,
  }) async {
    final String id = itemCollection.doc().id;
    user.itemsid.add(id);
    user.itemstitle.add(item.title);
    user.itemsicon.add(item.icon);
    user.itemsunit.add(item.unit);
    user.itemsdataType.add(item.dataType);
    await itemCollection.doc(id).set({
      'title': item.title,
      'icon': item.icon,
      'unit': item.unit,
      'dataType': item.dataType,
      'id': id,
      'isInUse': true
    });
    databaseServiceUser.updateuserData(
      user.uid,
      user.itemsid,
      user.itemstitle,
      user.itemsicon,
      user.itemsunit,
      user.itemsdataType,
    );
  }

  Future<void> deleteItemData({
    @required User user,
    @required Item item,
  }) async {
    //print(item.title);
    await itemCollection.doc(item.id).set({
      'isInUse': false,
    });
    for (int i = 0; i < user.itemsid.length; i++) {
      if (user.itemsid[i] == itemid) {
        user.itemsid.removeAt(i);
        user.itemstitle.removeAt(i);
        user.itemsicon.removeAt(i);
        user.itemsunit.removeAt(i);
        user.itemsdataType.removeAt(i);
      }
    }
    databaseServiceUser.updateuserData(
      user.uid,
      user.itemsid,
      user.itemstitle,
      user.itemsicon,
      user.itemsunit,
      user.itemsdataType,
    );
  }

  // itemmodels list from snapshot
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Item(
        title: doc.data()['title'] ?? '',
        icon: doc.data()['icon'] ?? '',
        unit: doc.data()['unit'] ?? '',
        dataType: doc.data()['dataType'] ?? -100,
        id: doc.data()['id'] ?? '',
      );
    }).toList();
  }

  //user data from snapshot
  Item _itemDataFromSnapshot(DocumentSnapshot snapshot) {
    return Item(
      title: snapshot.data()['title'],
      icon: snapshot.data()['icon'] ?? '',
      unit: snapshot.data()['unit'] ?? '',
      dataType: snapshot.data()['dataType'] ?? '',
      id: snapshot.data()['id'] ?? '',
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
  Stream<Item> get itemData {
    return itemCollection.doc(itemid).snapshots().map(_itemDataFromSnapshot);
  }

  Future<void> createItemDailyData(
      String itemId, String documentId, dynamic data, DateTime dateTime) async {
    final int date = dateTime.difference(DateTime(2020, 1, 1)).inDays;
    await itemCollection.doc(itemId).collection('data').doc(documentId).set({
      'data': data,
      'documentId': documentId,
      'datadate': date,
    });
  }

  Future<void> updateItemDailyData(
      String itemId, String documentId, dynamic data, DateTime dateTime) async {
    final int date = dateTime.difference(DateTime(2020, 1, 1)).inDays;
    await itemCollection.doc(itemId).collection('data').doc(documentId).set({
      'data': data,
      'documentId': documentId,
      'datadate': date,
    });
  }

  Future<void> deleteItemDailyData(String itemId, String documentId) async {
    await itemCollection
        .doc(itemId)
        .collection('data')
        .doc(documentId)
        .delete();
  }

  Future<dynamic> readItemDailyData(String itemId, String documentId) async {
    try {
      return await FirebaseFirestore.instance
          .collection('items/' + itemId + '/data')
          .doc(documentId)
          .get()
          .then((snapshot) {
        if (snapshot == null) {
          print('Error Occer : Maybe network problem (Offline) 🔧');
        } else if (snapshot.exists) {
          print('data');
          return snapshot.data()['data'];
        }
      });
    } on PlatformException catch (e) {
      print(e);
      return 'NetWorkError';
    }
  }

  Future<List<dynamic>> getListItemdata(String itemId) async {
    final int date = DateTime.now().difference(DateTime(2020, 1, 1)).inDays;
    final QuerySnapshot data = await FirebaseFirestore.instance
        .collection('items/' + itemId + '/data')
        .where('datadate', isLessThanOrEqualTo: date)
        .where('datadate', isGreaterThan: date - 30)
        .orderBy('datadate')
        .get();
    final List<dynamic> list = [];
    for (int i = 0; i < data.docs.length; i++) {
      final List<dynamic> docdata = [
        data.docs[i].data()['data'],
        data.docs[i].data()['documentId'],
        data.docs[i].data()['datadate'],
      ];
      list.add(docdata);
    }
    print(list);
    return list;
  }
}
