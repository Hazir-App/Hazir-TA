import 'Course.dart';

class Section {
  int sectionId;
  String sectionCode;
  String raName;
  String instructorName;
  Course courseSection;

  Section.fromMap(Map<String, dynamic> data) {
    sectionId = data['section_id'];
    sectionCode = data['section_code'];
    raName = data['ra_name'];
    courseSection = Course(
      courseId: data['course_id'],
      courseName: data['course_name'],
      courseCode: data['course_code'],
    );
  }
}
