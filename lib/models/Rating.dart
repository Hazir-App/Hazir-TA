import 'package:sqflite/sqflite.dart';

class Rating {
  String rated_by_user_id;
  String rated_to_user_id;
  int rated_course_id;
  double rating;
  Rating(){
    rating=5;
  }
  Rating.fromMap(Map<String, dynamic> data) {
    rated_by_user_id = data["rating_provider"];
    rated_to_user_id = data["rating_consumer"];
    rated_course_id = data["rating_course_id"];
    rating = data["rating_given"].toDouble();
  }

  update(Database database) async {
  await database.rawUpdate("UPDATE Rating SET rating_provider = '${rated_by_user_id}', rating_consumer = '${rated_to_user_id}', rating_given = ${rating}, rating_course_id = '${rated_course_id}' WHERE rating_provider = '${rated_by_user_id}' AND rating_consumer = '${rated_to_user_id}' AND rating_course_id = '${rated_course_id}'");
  }
  add(Database database) async {
    await database.rawInsert("INSERT INTO Rating(rating_provider, rating_consumer, rating_given, rating_course_id) VALUES ( '${rated_by_user_id}', '${rated_to_user_id}', '${rating}', '${rated_course_id}' );");
  }

}
