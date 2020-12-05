import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hazir_ta/models/User.dart';
import 'package:sqflite/sqflite.dart';

class Session {
  int sessionId;
  String sessionName;
  String sessionDate;
  String sessionStartTime;
  String sessionEndTime;
  int maxStudent;
  int courseId;
  int sectionId;
  String courseName;
  String courseCode;
  List<User> sessionBookedBy = [];
  User hostedBy;

  Session.fromMap(Map<String, dynamic> data) {
    sectionId = data['id_session'];
    sessionName = data['session_name'];
    sessionDate = data['session_date'];
    sessionStartTime = data['session_start_time'];
    sessionEndTime = data['session_end_time'];
    sessionEndTime = data['session_end_time'];
    maxStudent = data['max_student'];
    courseId = data['course_id'];
    sectionId = data['session_id'];
  }

  void loadMoreInfo(Database database, String userId, int role) async {
    if (role != 0) {
      List<Map> CourseNameAndCourseCode= await database.rawQuery(
          """select course_name, course_id
        from Course where course_id in (
        select course_id from Session
        where id_session in (
        select booked_session from Booking 
      where tutored_by_user = '$userId' and course_id = ${courseId}
    ))""");
      courseName = CourseNameAndCourseCode[0]['course_name'];
      courseCode = CourseNameAndCourseCode[0]['course_code'];
    } else {
      List<Map> CourseNameAndCourseCode= await database.rawQuery(
          """select course_name, course_id
        from Course where course_id in (
        select course_id from Session
        where id_session in (
        select booked_session from Booking 
      where booked_by_user = '$userId' and course_id = ${courseId}
    ))""");
      courseName = CourseNameAndCourseCode[0]['course_name'];
      courseCode = CourseNameAndCourseCode[0]['course_code'];
    }

    //
    // List<Map> bookedByUsers = await database.rawQuery(
    //     """select * from HazirUser
    //        where id_user in (
    //       select booked_by_user from Booking
    //       where booked_session = ${sessionId}
    //   )""");
    //
    // List<Map> tutoredByUser = await database.rawQuery(
    //     """select * from HazirUser
    //        where id_user in (
    //       select tutored_by_user from Booking
    //       where booked_session = ${sessionId}
    //   );""");
    //
    // print(tutoredByUser);


    // bookedByUsers.forEach((element) {
    //   sessionBookedBy.add(User.fromMap(element));
    // });

    //
    // hostedBy = User.fromMap(tutoredByUser[0]);


  }

}