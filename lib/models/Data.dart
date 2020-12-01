import 'package:sqflite/sqflite.dart';

import 'Course.dart';
import 'Section.dart';

class Data {
  final String userid;

  List<Course> allCourses = [];
  List<Section> allSections = [];
  List<Section> enrolledSection = [];


  Data(this.userid);
  Future<void> getAll(Database database) async {
    List<Map> allCourseMap = await database.rawQuery("SELECT course_id,course_name,course_code FROM Course");
    List<Map> allSectionMap = await database.rawQuery(
        "SELECT section_id, section_code,(SELECT ra_name from ResearchAssistants where S.section_ra_id = section_ra_id) as ra_name, (SELECT instructor_name from Instructors where S.section_instrucutor_id = section_instrucutor_id) as instructor_name, C.course_id,C.course_name,C.course_code FROM Section S INNER JOIN Course C ON S.section_course_id = C.course_id");
    List<Map> enrolledSectionMap =await database.rawQuery("SELECT section_id, section_code,(SELECT ra_name from ResearchAssistants where S.section_ra_id = section_ra_id) as ra_name, (SELECT instructor_name from Instructors where S.section_instrucutor_id = section_instrucutor_id) as instructor_name, C.course_id,C.course_name,C.course_code FROM Section S INNER JOIN Course C ON S.section_course_id = C.course_id WHERE S.section_id in (SELECT enrolled_section_id FROM EnrolledCourse where enrolled_by_user_id='ar06194')");

    allCourseMap.forEach((element) {
      allCourses.add(Course.fromMap(element));
    });

    allSectionMap.forEach((element) {
      allSections.add(Section.fromMap(element));
    });

    enrolledSectionMap.forEach((element) {
      enrolledSection.add(Section.fromMap(element));
    });

  }
}
