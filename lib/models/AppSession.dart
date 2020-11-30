import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hazir_ta/sql_queries.dart';
import 'dart:core';
import 'User.dart';

class AppSession extends ChangeNotifier {
  Database database;

  AppSession() {
    loadDatabase();
  }

  void loadDatabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + 'hazir_ta.db';
    database = await openDatabase(path, onCreate: _onCreateDatabase, version: 1);
    await database.execute(init_database).catchError((oe) {
      print(oe);
    });
    //User.login(database, "ar06194", "12345678");
    //var a = await database.rawQuery("Select * from Roles");

    notifyListeners();
  }

  void _onCreateDatabase(Database db, int version) async {
    print("called");
    await db.execute(init_database);
  }

  void loginUser(String username, String password) {
    User.login(database, "ar06194", "12345678");
  }
}
