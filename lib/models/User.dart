import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hazir_ta/models/query_helper.dart';
import 'package:sqflite/sqflite.dart';

import 'Section.dart';
import 'query_helper.dart';

class User {
  String idUser;
  String firstName;
  String lastName;
  String email;
  String profileUrl;
  UserRole userRole;
  List<Section> enrolledSections = [];
  List<Section> tutoredSections = [];

  User();
  User.fromMap(Map<String, dynamic> data) {
    idUser = data["id_user"];
    firstName = data["first_name"];
    lastName = data["last_name"];
    email = data["email"];
    profileUrl = data["profile_url"];
    userRole = data["user_role"] == 0 ? UserRole.student : UserRole.tutor;
  }

  void loadData(Database database) async {
    List<Map> enrolledSectionMap = await database.rawQuery(
        "SELECT section_id, section_code,(SELECT ra_name from ResearchAssistants where S.section_ra_id = section_ra_id) as ra_name, (SELECT instructor_name from Instructors where S.section_instrucutor_id = section_instrucutor_id) as instructor_name, C.course_id,C.course_name,C.course_code FROM Section S INNER JOIN Course C ON S.section_course_id = C.course_id WHERE S.section_id in (SELECT enrolled_section_id FROM EnrolledCourse where enrolled_by_user_id='sa06195')");
    List<Map> tutoredSectionMap = await database.rawQuery(
        "SELECT section_id, section_code,( SELECT ra_name FROM ResearchAssistants WHERE S.section_ra_id = section_ra_id) AS ra_name, ( SELECT instructor_name FROM Instructors WHERE S.section_instrucutor_id = section_instrucutor_id ) AS instructor_name, C.course_id, C.course_name, C.course_code FROM Section S INNER JOIN Course C ON S.section_course_id = C.course_id WHERE S.section_id IN ( SELECT tutored_section_id FROM TutoredCourse WHERE tutored_by_user_id = 'sa06195' and approved=1 )");
    await enrolledSectionMap.forEach((element) async {
      Section s = Section.fromMap(element);
      await s.courseSection.getTutors(database);
      enrolledSections.add(s);
    });

    tutoredSectionMap.forEach((element) {
      Section s = Section.fromMap(element);
      tutoredSections.add(s);
    });

    print(enrolledSectionMap);
  }

  void updateUserDatabase(Database database) async {
    await database.rawUpdate(
        "UPDATE HazirUser SET first_name = '${firstName}', last_name = '${lastName}', email = '${email}', profile_url = ${profileUrl == null ? 'NULL' : QueryHelper.stringArgument(profileUrl)}, user_role = 0 WHERE id_user = '${idUser}'");
  }

  static login(Database db, String id, String password) async {
    List<Map> userData =
        await db.rawQuery("select * from HazirUser where user_password=${QueryHelper.stringArgument(password)} and id_user=${QueryHelper.stringArgument(id)}");

    if (userData.isEmpty) {
      return null;
    } else {
      User u = User.fromMap(userData[0]);
      await u.loadData(db);
      return u;
    }
  }
}

enum UserRole {
  student,
  tutor,
}
