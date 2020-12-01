import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hazir_ta/models/query_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hazir_ta/sql_queries.dart';
import 'dart:core';
import 'Data.dart';
import 'User.dart';

class AppSession extends ChangeNotifier {
  Database database;
  User user;
  Data data;

  AppSession() {
    loadDatabase();
  }

  void loadDatabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + 'hazir_ta_sql.db';
    database = await openDatabase(
      path,
      onCreate: _onCreateDatabase,
      version: 1,
      onConfigure: _onConfigure,
    );
    notifyListeners();
  }

  void _onCreateDatabase(Database db, int version) async {
    print("database not created ... creating one ...");
    await QueryHelper.executeRawQueries(init_database, db);
  }

  void _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  void loginUser(String username, String password) async {

    user  = await User.login(database, username, password);
    if(user==null){
      Fluttertoast.showToast(
          msg: "Invalid username or password!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      data = Data(user.idUser);
      await data.getAll(database);
    }
    notifyListeners();
  }

}
