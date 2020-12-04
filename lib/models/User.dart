import 'package:hazir_ta/models/Rating.dart';
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
  double averageRating = 0;

  List<Section> enrolledSections = [];
  List<Section> tutoredSections = [];
  List<Rating> ratings = [];

  User();

  User.fromMap(Map<String, dynamic> data) {
    idUser = data["id_user"];
    firstName = data["first_name"];
    lastName = data["last_name"];
    email = data["email"];
    profileUrl = data["profile_url"];
    userRole = data["user_role"] == 0 ? UserRole.student : UserRole.tutor;
  }

  double courseRating(int course_id) {
    double c_rating = 0;
    int count=0;
    ratings.forEach((element) {
      if (element.rated_course_id == course_id) {
        c_rating += element.rating;
        count++;
      }
    });

    return c_rating / count;
  }

  void loadData(Database database) async {
    List<Map> enrolledSectionMap = await database.rawQuery(
        "SELECT section_id, section_code,(SELECT ra_name from ResearchAssistants where S.section_ra_id = section_ra_id) as ra_name, (SELECT instructor_name from Instructors where S.section_instrucutor_id = section_instrucutor_id) as instructor_name, C.course_id,C.course_name,C.course_code FROM Section S INNER JOIN Course C ON S.section_course_id = C.course_id WHERE S.section_id in (SELECT enrolled_section_id FROM EnrolledCourse where enrolled_by_user_id='${idUser}')");
    List<Map> tutoredSectionMap = await database.rawQuery(
        "SELECT section_id, section_code,( SELECT ra_name FROM ResearchAssistants WHERE S.section_ra_id = section_ra_id) AS ra_name, ( SELECT instructor_name FROM Instructors WHERE S.section_instrucutor_id = section_instrucutor_id ) AS instructor_name, C.course_id, C.course_name, C.course_code FROM Section S INNER JOIN Course C ON S.section_course_id = C.course_id WHERE S.section_id IN ( SELECT tutored_section_id FROM TutoredCourse WHERE tutored_by_user_id = '${idUser}' and approved=1 )");
    enrolledSectionMap.forEach((element) {
      Section s = Section.fromMap(element);
      enrolledSections.add(s);
    });

    tutoredSectionMap.forEach((element) {
      Section s = Section.fromMap(element);
      tutoredSections.add(s);
    });

    for (int i = 0; i < enrolledSections.length; i++) {
      await enrolledSections[i].courseSection.getTutors(database);
    }

    List<Map> ratingMap = await database.rawQuery("Select * from rating where rating_consumer='${idUser}' or rating_provider='${idUser}'");
    ratingMap.forEach((element) {
      ratings.add(Rating.fromMap(element));
    });

    updateRating();
  }

  void updateRating(){
    double sum=0;
    ratings.forEach((element) {
      sum += element.rating;
    });
    averageRating = sum / ratings.length;
  }

  void updateUserDatabase(Database database) async {
    await database.rawUpdate(
        "UPDATE HazirUser SET first_name = '${firstName}', last_name = '${lastName}', email = '${email}', profile_url = ${profileUrl == null ? 'NULL' : QueryHelper.stringArgument(profileUrl)} WHERE id_user = '${idUser}'");
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
