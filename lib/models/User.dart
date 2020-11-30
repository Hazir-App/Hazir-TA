import 'package:sqflite/sqflite.dart';

class User {
  String idUser;
  String firstName;
  String lastName;
  String email;
  String profileUrl;
  UserRole userRole;

  User.fromMap(Map<String, dynamic> data) {
    idUser = data["id_user"];
    firstName = data["first_name"];
    lastName = data["last_name"];
    email = data["email"];
    profileUrl = data["profile_url"];
    userRole = data["user_role"];
  }

  static login(Database db, String id, String password) async {
    List<Map> userData = await db.rawQuery("select * from HazirUser;");
    print(userData);
    //return User.fromMap(userData[0]);
  }
}

enum UserRole {
  student,
  tutor,
}
