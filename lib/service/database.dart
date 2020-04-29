import 'dart:async';

import 'package:flutter_check_hub/models/Item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseFactory {
  Future<Database> create() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (Database db, int version) async {
        return db.execute(
          '''create table items (
          id int primary key,
          title text
          )''',
        );
      },
      version: 1,
    );
  }
}

class DatabaseService {
  DatabaseFactory databaseFactory = DatabaseFactory();
  static const String _tablename = 'items';
  static const String _title = 'title';
  static const String _id = 'id';
  //static const _data = 'data';

  Database _db;

  Future<void> open() async {
    _db = await databaseFactory.create();
  }

  Future<void> insert(int id, String title) async {
    await _db.insert(
      _tablename,
      <String, dynamic>{
        _id: id,
        _title: title,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Item> fetch(int id) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      _tablename,
      columns: <String>[_id, _title],
      where: '$_id=?',
      whereArgs: <dynamic>[id],
    );
    if (maps.isNotEmpty) {
      return Item(
        id: maps.first[_id],
        title: maps.first[_title],
      );
    }
    return null;
  }

  Future<void> delete(int id) async {
    await _db.delete(
      _tablename,
      where: 'id = ?',
      whereArgs: <int>[id],
    );
  }

  Future<void> update(int id, String title) async {
    await _db.update(
      _tablename,
      <String, dynamic>{
        _id: id,
        _title: title,
      },
      where: '_id= ?',
      whereArgs: <int>[id],
    );
  }

  Future<void> close() async => _db?.close();
}

class DatabaseOperater {
  DatabaseOperater(this.databaseFactory);
  DatabaseFactory databaseFactory;

  Future<void> save(int id, String title) async {
    final DatabaseService databaseService = DatabaseService();
    try {
      await databaseService.open();
      final Item result = await databaseService.fetch(id);
      if (result == null)
        await databaseService.insert(id, title);
      else
        await databaseService.update(id, title);
    } on Exception catch (e) {
      print(e);
    } finally {
      print(await databaseService.fetch(id));
      await databaseService.close();
    }
  }

  Future<Item> fecth(int id) async {
    final DatabaseService databaseService = DatabaseService();
    try {
      await databaseService.open();
      print(await databaseService.fetch(id));
      return await databaseService.fetch(id);
    } on Exception catch (e) {
      print(e);
    } finally {
      await databaseService.close();
    }
    return null;
  }

  Future<void> delete(int id) async {
    final DatabaseService databaseService = DatabaseService();
    try {
      await DatabaseService().open();
      await DatabaseService().delete(id);
    } on Exception catch (e) {
      print(e);
    } finally {
      await databaseService.close();
    }
  }
}
