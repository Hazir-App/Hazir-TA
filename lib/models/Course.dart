import 'package:sqflite/sqflite.dart';

import 'User.dart';

class Course{
  int courseId;
  String courseName;
  String courseCode;
  List<User> tutors = [];
  Course.fromMap(Map<String, dynamic> data) {
   courseId = data['course_id'];
   courseName = data['course_name'];
   courseCode = data['course_code'];

  }

  void getTutors(Database database) async {
    List<Map> tutorMap = await database.rawQuery(
        "select * from HazirUser where id_user in (select tutored_by_user_id from TutoredCourse where tutored_section_id in (select section_id from section where section_course_id in (select course_id from Course where course_id=${courseId})))");
    tutorMap.forEach((element) {
      User u = User.fromMap(element);
      tutors.add(u);
    });
    for (int i = 0; i < tutors.length; i++) {
      await tutors[i].loadData(database);
    }
  }



  Course({this.courseId,this.courseName,this.courseCode});
}