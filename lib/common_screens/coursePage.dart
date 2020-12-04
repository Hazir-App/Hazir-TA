import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hazir_ta/models/AppSession.dart';
import 'package:hazir_ta/models/Course.dart';
import 'package:hazir_ta/models/Section.dart';
import 'package:hazir_ta/student_screens/tutorProfileScreen.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CoursePage extends StatefulWidget {
  final Section section;
  final Course course;
  final int index;
  final bool tutoredCourse;

  const CoursePage({Key key, this.index, this.section, this.course, this.tutoredCourse}) : super(key: key);

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  CalendarController _calendarController = CalendarController();

  sessionCalenderView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
          child: Text(
            "Your sessions",
            style: TextStyle(letterSpacing: 2.0, color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        TableCalendar(
          calendarController: _calendarController,
          calendarStyle: CalendarStyle(
            todayColor: Theme.of(context).accentColor,
            selectedColor: Theme.of(context).primaryColor,
            markersColor: Theme.of(context).primaryColorLight,
          ),
        ),
      ],
    );
  }

  courseDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 15.0),
            child: Text(
              "Info",
              style: TextStyle(letterSpacing: 2.0, color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Instructor",
                style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text("${widget.section.instructorName}", style: TextStyle(color: Theme
                  .of(context)
                  .primaryColor, fontSize: 18))
            ],
          ),
          SizedBox(
            height: 14.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Research Assistant",
                style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(widget.section.raName, style: TextStyle(color: Theme
                  .of(context)
                  .primaryColor, fontSize: 18))
            ],
          )
        ],
      ),
    );
  }

  availablePeerTutors() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.course.tutors.isEmpty
              ? Container(
              height: 500,
              child: Text(
                "No Tutor Available!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 2.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ))
              : Center(
            child: Text(
              "Available TAs",
              style: TextStyle(letterSpacing: 2.0, color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.course.tutors.length,
              itemBuilder: (context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TutorProfile()),
                      );
                    },
                    child: Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 23,
                                  backgroundImage: widget.course.tutors[index].profileUrl == null
                                      ? NetworkImage(
                                      "https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg")
                                      : NetworkImage("${widget.course.tutors[index].profileUrl}"),
                                ),
                              ),
                              Text(
                                "${widget.course.tutors[index].firstName + " " + widget.course.tutors[index].lastName}",
                                style: TextStyle(color: Theme
                                    .of(context)
                                    .primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Course Rating",
                                    style: TextStyle(color: Theme
                                        .of(context)
                                        .primaryColor, fontSize: 12),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.star_half,
                                        color: Theme.of(context).primaryColor,
                                        size: 18,
                                      ),
                                      Center(
                                        child: Text(
                                          "${widget.course.tutors[index].courseRating(widget.section.courseSection.courseId).toStringAsFixed(1)}",
                                          style: TextStyle(color: Theme
                                              .of(context)
                                              .primaryColor, fontSize: 12.0),
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "Avg Rating",
                                    style: TextStyle(color: Theme
                                        .of(context)
                                        .primaryColor, fontSize: 12),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.star_half,
                                        color: Theme.of(context).primaryColor,
                                        size: 18,
                                      ),
                                      Center(
                                        child: Text(
                                          "${widget.course.tutors[index].averageRating.toStringAsFixed(1)}",
                                          style: TextStyle(color: Theme
                                              .of(context)
                                              .primaryColor, fontSize: 12.0),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }

  courseDeleteButton() {
    return FlatButton(
      height: 60.0,
      color: Colors.red,
      padding: EdgeInsets.all(0.0),
      onPressed: () async {
        Navigator.pop(context);
        if (widget.tutoredCourse) {
          await context
              .read<AppSession>()
              .database
              .rawDelete(
              "DELETE FROM TutoredCourse WHERE  tutred_by_user_id = '${context
                  .read<AppSession>()
                  .user
                  .idUser}' AND tutored_section_id = '${context
                  .read<AppSession>()
                  .user
                  .enrolledSections[widget.index].sectionId}'");
          context
              .read<AppSession>()
              .user
              .tutoredSections
              .removeAt(widget.index);
        } else {
          await context
              .read<AppSession>()
              .database
              .rawDelete(
              "DELETE FROM EnrolledCourse WHERE  enrolled_by_user_id = '${context
                  .read<AppSession>()
                  .user
                  .idUser}' AND enrolled_section_id = '${context
                  .read<AppSession>()
                  .user
                  .enrolledSections[widget.index].sectionId}'");
          context
              .read<AppSession>()
              .user
              .enrolledSections
              .removeAt(widget.index);
        }

        context.read<AppSession>().update();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      child: Text(
        "Delete this course",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor));
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 90,
            title: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.section.courseSection.courseCode,
                        style: TextStyle(fontSize: 15.0),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.section.courseSection.courseName,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Section",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.section.sectionCode,
                        style: TextStyle(fontSize: 23.0),
                      )
                    ],
                  )
                ],
              ),
            ),
            elevation: 5,
          ),
          body: ListView(
            padding: EdgeInsets.all(0.0),
            physics: BouncingScrollPhysics(),
            children: [
              courseDetails(),
              widget.tutoredCourse ? sessionCalenderView() : availablePeerTutors(),
              courseDeleteButton(),
            ],
          ),
        ));
  }
}
