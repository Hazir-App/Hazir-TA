import 'dart:core';

import 'package:flutter/material.dart';
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

  void loadMoreInfo(Database database, String userId) async {
    List<Map> bookedSessions= await database.rawQuery(
      """select course_name, course_id
        from Course where course_id in (
        select course_id from Session
        where id_session in (
        select booked_session from Booking 
      where tutored_by_user = '$userId'   
    ))""");

    courseName = bookedSessions[0]['course_name'];
    courseCode = bookedSessions[0]['course_code'];
  }

}