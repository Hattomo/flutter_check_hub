import 'dart:async';

import 'package:flutter_check_hub/models/data_type.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseFactory {
  Future<Database> create() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'database2.db'),
      onCreate: (Database db, int version) async {
        return db.execute(
          '''create table datatable (
          tableName text primary key,
          dataType int
          )''',
        );
      },
      version: 1,
    );
  }
}

class DatabaseService {
  DatabaseFactory databaseFactory = DatabaseFactory();
  static const String _tablename = 'datatable';
  static const String _titlecolumn = 'tablename';
  static const String _dataType = 'dataType';
  //static const _id = 'id';

  Database _db;

  Future<void> open() async {
    _db = await databaseFactory.create();
  }

  Future<void> insert(int dataType, String titlecolumn) async {
    await _db.insert(
      _tablename,
      <String, dynamic>{
        _titlecolumn: titlecolumn,
        _dataType: dataType,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<DataTable> fetch(String titlecolumn) async {
    try {
      final List<Map> maps = await _db.query(
        _tablename,
        columns: <String>[_dataType, _titlecolumn],
        where: '$_titlecolumn=?',
        whereArgs: <String>[titlecolumn],
      );
      if (maps.isNotEmpty) {
        return DataTable(
          dataType: maps.first['dataType'],
          tablename: maps.first['tableName'],
        );
      }
      return null;
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> delete(String titlecolumn) async {
    await _db.delete(
      _dataType,
      where: 'titlecolumn = ?',
      whereArgs: <String>[titlecolumn],
    );
  }

  Future<void> update(int dataType, String titlecolumn) async {
    await _db.update(
      _dataType,
      <String, dynamic>{
        _dataType: dataType,
        _titlecolumn: titlecolumn,
      },
      where: 'titlecolumn= ?',
      whereArgs: <String>[titlecolumn],
    );
  }

  Future<void> close() async => _db?.close();
}

class DatabaseOperater {
  DatabaseOperater(this.databaseFactory);
  DatabaseFactory databaseFactory;

  Future<void> save(int dataType, String titlecolumn) async {
    final DatabaseService databaseService = DatabaseService();
    try {
      await databaseService.open();
      final DataTable result = await databaseService.fetch(titlecolumn);
      if (result == null)
        await databaseService.insert(dataType, titlecolumn);
      else
        await databaseService.update(dataType, titlecolumn);
    } on Exception catch (e) {
      print(e);
    } finally {
      print(await databaseService.fetch(titlecolumn));
      await databaseService.close();
    }
  }

  Future<DataTable> fecth(String titlecoumn) async {
    final DatabaseService databaseService = DatabaseService();
    try {
      await databaseService.open();
      print(await databaseService.fetch(titlecoumn));
      return await databaseService.fetch(titlecoumn);
    } on Exception catch (e) {
      print(e);
    } finally {
      await databaseService.close();
    }
    return null;
  }

  Future<void> delete(String titlecolumn) async {
    final DatabaseService databaseService = DatabaseService();
    try {
      await DatabaseService().open();
      await DatabaseService().delete(titlecolumn);
    } on Exception catch (e) {
      print(e);
    } finally {
      await databaseService.close();
    }
  }
}
