import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hazir_ta/models/AppSession.dart';
import 'package:hazir_ta/models/Course.dart';
import 'package:hazir_ta/models/Rating.dart';
import 'package:hazir_ta/models/User.dart';
import 'package:provider/provider.dart';

class RateTutor extends StatefulWidget {
  final User user;
  final Course course;
  final Function updateUser;
  final int index;

  const RateTutor({Key key, this.user, this.course,this.updateUser,this.index}) : super(key: key);
  @override
  _RateTutorState createState() => _RateTutorState();
}

class _RateTutorState extends State<RateTutor> {
  Rating _rating;
  bool _noPreviousRating;
  ratingForm() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Course Name",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                ),
                Text(
                  "${widget.course.courseName}",
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Course Code",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                ),
                Text(
                  "${widget.course.courseCode}",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rating",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                ),
                RatingBar.builder(
                  initialRating: _rating.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 30,
                  glowColor: Theme.of(context).accentColor,
                  itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Theme.of(context).accentColor,
                  ),
                  onRatingUpdate: (rating) {

                      _rating.rating = rating;

                  },
                )
              ],
            ),
          ),
          Spacer(),
          FlatButton(
            height: 60.0,
            minWidth: MediaQuery.of(context).size.width*0.8,
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.all(8.0),
            onPressed: () async {
              if(_noPreviousRating){
                await _rating.add(context.read<AppSession>().database);

              }else{
                await _rating.update(context.read<AppSession>().database);

              }
              if(_noPreviousRating){
                context.read<AppSession>().user.ratings.add(_rating);
              }else{
                context.read<AppSession>().user.ratings[context.read<AppSession>().user.ratings.indexWhere((element) => element.rated_by_user_id == context.read<AppSession>().user.idUser && element.rated_to_user_id == widget.user.idUser && element.rated_course_id==widget.course.courseId)] = _rating;
              }
              context.read<AppSession>().user.updateRating();




              widget.user.ratings.add(_rating);
              widget.user.updateRating();
              widget.updateUser(widget.user);
              Navigator.pop(context);

            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
            child: Text(
              "${_noPreviousRating ? "Add Rating" : "Update Rating"}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          )
        ],
      ),
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<Rating> _previousRating = context
        .read<AppSession>()
        .user
        .ratings
        .where((element) => element.rated_by_user_id == context.read<AppSession>().user.idUser && element.rated_to_user_id == widget.user.idUser && element.rated_course_id==widget.course.courseId).toList();

    if (_previousRating.isEmpty) {
      _noPreviousRating = true;
      _rating = Rating();
      _rating.rating =5 ;
      _rating.rated_by_user_id = context.read<AppSession>().user.idUser;
      _rating.rated_to_user_id = widget.user.idUser;
      _rating.rated_course_id = widget.course.courseId;
    } else {
      _noPreviousRating = false;
      _rating = _previousRating[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Rate Tutor"),
      ),
      body: ratingForm(),
    ));
  }
}
