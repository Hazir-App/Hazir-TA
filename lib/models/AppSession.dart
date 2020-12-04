import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hazir_ta/models/query_helper.dart';
import 'package:hazir_ta/sql_queries.dart';
import 'package:sqflite/sqflite.dart';

import 'Course.dart';
import 'Section.dart';
import 'User.dart';

class AppSession extends ChangeNotifier {
  Database database;
  User user;
  List<Course> allCourses = [];
  List<Section> allSections = [];
  List<User> allTutors = [];

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
    await _loadData();
    notifyListeners();
  }


  void _loadData() async {
    List<Map> allCourseMap = await database.rawQuery("SELECT course_id,course_name,course_code FROM Course");
    List<Map> allSectionMap = await database.rawQuery(
        "SELECT section_id, section_code,(SELECT ra_name from ResearchAssistants where S.section_ra_id = section_ra_id) as ra_name, (SELECT instructor_name from Instructors where S.section_instrucutor_id = section_instrucutor_id) as instructor_name, C.course_id,C.course_name,C.course_code FROM Section S INNER JOIN Course C ON S.section_course_id = C.course_id");
    allCourseMap.forEach((element) {
      Course c = Course.fromMap(element);
      allCourses.add(c);
    });

    allSectionMap.forEach((element) {
      Section s = Section.fromMap(element);
      allSections.add(s);
    });
    print(allCourses);
  }

  void _onCreateDatabase(Database db, int version) async {
    print("database not created ... creating one ...");
    await QueryHelper.executeRawQueries(init_database, db);
  }

  void _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = OFF');
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
          fontSize: 16.0);
    }
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }
}
