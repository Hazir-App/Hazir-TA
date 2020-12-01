class Course{
  int courseId;
  String courseName;
  String courseCode;

  Course.fromMap(Map<String, dynamic> data) {
   courseId = data['course_id'];
   courseName = data['course_name'];
   courseCode = data['course_code'];
  }

  Course({this.courseId,this.courseName,this.courseCode});
}