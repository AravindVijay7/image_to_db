/*

import 'dart:io';

import 'package:sqflite/sqflite.dart';

class DbHelper {
  //podesavanje singltona 1/3
  static final DbHelper _dbHelper = DbHelper._internal();
  //table name
  String tblName = "todo";
  //columns
  String colId = "id";
  String colTitle = "title";
  String colDescription = "description";
  String colPriority = "priority";
  String colDate = "date";
   DbHelper._internal();

   factory DbHelper() {
    return _dbHelper;
  }

  static Database? _db;
  Future<Database?> get db async {
    _db ??= await initializeDb();
    return _db;
  }

   Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "todos.db";
    var dbTodos = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbTodos;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tblName($colId INTEGER PRIMARY KEY, $colTitle TEXT, $colDescription TEXT, $colPriority INTEGER, $colDate TEXT)");
  }

  Future<int> insertTodo(Todo todo) async {
    Database db = await this.db;
    var result = await db.insert(tblName, todo.toMap());
    return result;
  }

  Future<List> getTodos() async {
    Database db = await this.db;
    var result =
    await db.rawQuery("SELECT * FROM $tblName order by $colPriority ASC");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $tblName"));
    return result;
  }

  Future<int> updateTodo(Todo todo) async {
    Database db = await this.db;
    var result = await db.update(tblName, todo.toMap(),
        where: "$colId = ?", whereArgs: [todo.id]);
    return result;
  }

  Future<int> deleteTodo(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("DELETE FROM $tblName WHERE $colId =  $id");
    return result;
  }
}

*/
