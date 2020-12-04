class Rating {
  String rated_by_user_id;
  int rated_to_user_id;
  int rated_course_id;
  double rating;

  Rating.fromMap(Map<String, dynamic> data) {
    rated_by_user_id = data["rating_provider"];
    rated_to_user_id = data["rating_consumer"];
    rated_course_id = data["rating_course_id"];
    rating = data["rating_given"].toDouble();
  }

// update(Database database){
//   database.update(, values)
// }
}
