import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/models/todo.dart';

class DbHelper {
  String tblName = "todos";
  String colId = "id";
  String colTitle = "title";
  String colExplanation = "explanation";
  String colisImportant = "isImportant";
  String colisDone = "isDone";

  DbHelper._internal();
  static final DbHelper _dbHelper = DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  static Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await createDb();
    }
    return _db!;
  }

  Future<Database> createDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "todo.db";
    var todoDb = await openDatabase(path, version: 1, onCreate: create);
    return todoDb;
  }

  void create(Database db, int version) async {
    await db.execute(
        "Create table $tblName($colId integer primary key,$colTitle text,$colExplanation text,$colisImportant int, $colisDone int)");
  }

  Future<int> add(ToDo todo) async {
    Database db = await this.db;
    var result = await db.insert(tblName, todo.toMap());
    return result;
  }

  Future<List> getToDos() async {
    Database db = await this.db;
    var result = await db.rawQuery("Select * from $tblName");
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("Delete from $tblName where $colId = $id");
    return result;
  }

  Future<int> update(ToDo toDo) async {
    Database db = await this.db;
    var result = await db.update(tblName, toDo.toMap());
    return result;
  }
}
