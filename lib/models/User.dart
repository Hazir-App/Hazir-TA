import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hazir_ta/models/query_helper.dart';
import 'package:sqflite/sqflite.dart';

class User {
  String idUser;
  String firstName;
  String lastName;
  String email;
  String profileUrl;
  UserRole userRole;
  User();
  User.fromMap(Map<String, dynamic> data) {
    idUser = data["id_user"];
    firstName = data["first_name"];
    lastName = data["last_name"];
    email = data["email"];
    profileUrl = data["profile_url"];
    userRole = data["user_role"]==0?UserRole.student:UserRole.tutor;
  }

  static login(Database db, String id, String password) async {
    List<Map> userData = await db.rawQuery("select * from HazirUser where user_password=${QueryHelper.stringArgument(password)} and id_user=${QueryHelper.stringArgument(id)}");
    List<Map> userData1 = await db.rawQuery("select * from HazirUser");

    print(userData1);
    if (userData.isEmpty) {
      return null;
    } else {
      return User.fromMap(userData[0]);
    }
  }
}

enum UserRole {
  student,
  tutor,
}
