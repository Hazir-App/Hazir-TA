import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hazir_ta/common_screens/accountSettings.dart';
import 'package:hazir_ta/common_screens/addEnrolledCourse.dart';
import 'package:hazir_ta/common_screens/addTutoredCourse.dart';
import 'package:hazir_ta/common_screens/coursePage.dart';
import 'package:hazir_ta/models/AppSession.dart';
import 'package:hazir_ta/models/User.dart';
import 'package:hazir_ta/tutor_screens/tutorSessionInfo.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class TutorDashboard extends StatefulWidget {
  @override
  _TutorDashboardState createState() => _TutorDashboardState();
}

class _TutorDashboardState extends State<TutorDashboard> {
  CalendarController _calendarController = CalendarController();

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  dashboardAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          fit: StackFit.loose,
          children: [
            Material(
              shadowColor: Colors.black,
              elevation: 5,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(70.0)),
              child: Container(
                height: 170,
                width: 300,
                decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.only(bottomRight: Radius.circular(70.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 45.0, horizontal: 45.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 42,
                      backgroundImage: context
                          .watch<AppSession>()
                          .user
                          .profileUrl == null
                          ? NetworkImage(
                          "https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg")
                          : NetworkImage("${context
                          .watch<AppSession>()
                          .user
                          .profileUrl}"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome,",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          "${context
                              .watch<AppSession>()
                              .user
                              .firstName}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        context
                            .watch<AppSession>()
                            .user
                            .userRole == UserRole.tutor
                            ? Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.star_half,
                              color: Colors.white,
                            ),
                            Center(
                              child: Text(
                                "${context
                                    .watch<AppSession>()
                                    .user
                                    .averageRating == 0 ? "N/A" : context
                                    .watch<AppSession>()
                                    .user
                                    .averageRating}",
                                style: TextStyle(color: Colors.white, fontSize: 15.0),
                              ),
                            )
                          ],
                        )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 25.0,
            horizontal: 25.0,
          ),
          child: Material(
            color: Theme.of(context).primaryColor,
            elevation: 5.0,
            borderRadius: BorderRadius.circular(70),
            child: InkWell(
              focusColor: Colors.white,
              splashColor: Theme.of(context).primaryColor,
              highlightColor: Theme.of(context).primaryColor,
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.person_rounded,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
              borderRadius: BorderRadius.circular(40),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountSettings()),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  enrolledCourses() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Enrolled Courses",
                style: TextStyle(letterSpacing: 2.0, color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddEnrolledCourse()),
                    );
                  })
            ],
          ),
        ),
        context
            .watch<AppSession>()
            .user
            .enrolledSections
            .isEmpty
            ? Container(height: 50, child: Center(child: Text("No Enrolled Courses!")))
            : Container(
          width: double.maxFinite,
          height: 170,
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.right,
            color: Theme
                .of(context)
                .primaryColor,
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                scrollDirection: Axis.horizontal,
                itemCount: context
                    .watch<AppSession>()
                    .user
                    .enrolledSections
                    .length,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CoursePage(
                                  index: index,
                                  section: context
                                      .watch<AppSession>()
                                      .user
                                      .enrolledSections[index == null ? 0 : index],
                                  course: context
                                      .watch<AppSession>()
                                      .user
                                      .enrolledSections[index == null ? 0 : index].courseSection,
                                  tutoredCourse: false,
                                ),
                          ),
                        );
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(30.0),
                        elevation: 5.0,
                        child: Container(
                          height: 150,
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${context
                                      .watch<AppSession>()
                                      .user
                                      .enrolledSections[index].courseSection.courseCode}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(letterSpacing: 1.0, color: Theme
                                      .of(context)
                                      .primaryColor, fontWeight: FontWeight.bold, fontSize: 22),
                                ),
                                Text(
                                  "${context
                                      .watch<AppSession>()
                                      .user
                                      .enrolledSections[index].courseSection.courseName}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(letterSpacing: 1.0, color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                Text(
                                  "${context
                                      .watch<AppSession>()
                                      .user
                                      .enrolledSections[index].sectionCode}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(letterSpacing: 1.0, color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }

  tutoredCourses() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tutored Courses",
                style: TextStyle(letterSpacing: 2.0, color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTutoredCourse()),
                    );
                  })
            ],
          ),
        ),
        context
            .watch<AppSession>()
            .user
            .tutoredSections
            .isEmpty
            ? Container(height: 50, child: Center(child: Text("No Enrolled Courses!")))
            : Container(
          width: double.maxFinite,
          height: 170,
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.right,
            color: Theme
                .of(context)
                .primaryColor,
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                scrollDirection: Axis.horizontal,
                itemCount: context
                    .watch<AppSession>()
                    .user
                    .tutoredSections
                    .length,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CoursePage(
                                  index: index,
                                  section: context
                                      .watch<AppSession>()
                                      .user
                                      .tutoredSections[index == null ? 0 : index],
                                  course: context
                                      .watch<AppSession>()
                                      .user
                                      .tutoredSections[index == null ? 0 : index].courseSection,
                                  tutoredCourse: true,
                                ),
                          ),
                        );
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(30.0),
                        elevation: 5.0,
                        child: Container(
                          height: 150,
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${context
                                      .watch<AppSession>()
                                      .user
                                      .tutoredSections[index].courseSection.courseCode}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(letterSpacing: 1.0, color: Theme
                                      .of(context)
                                      .primaryColor, fontWeight: FontWeight.bold, fontSize: 22),
                                ),
                                Text(
                                  "${context
                                      .watch<AppSession>()
                                      .user
                                      .tutoredSections[index].courseSection.courseName}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(letterSpacing: 1.0, color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                Text(
                                  "${context
                                      .watch<AppSession>()
                                      .user
                                      .tutoredSections[index].sectionCode}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(letterSpacing: 1.0, color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }

  sessionCalenderView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "All Sesssions",
                style: TextStyle(letterSpacing: 2.0, color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTutoredCourse()),
                    );
                  })
            ],
          ),
        ),
        Material(
          elevation: 5.0,
          child: TableCalendar(
            rowHeight: 45.0,
            calendarController: _calendarController,
            calendarStyle: CalendarStyle(
              todayColor: Theme
                  .of(context)
                  .accentColor,
              selectedColor: Theme
                  .of(context)
                  .primaryColor,
              markersColor: Theme
                  .of(context)
                  .primaryColorLight,
            ),
          ),
        ),
      ],
    );
  }

  timeSlotsView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Timeslots",
                style: TextStyle(letterSpacing: 2.0, color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTutoredCourse()),
                    );
                  })
            ],
          ),
        ),
        Container(
          child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TutorSessionInfoScreen()),
                      );
                    },
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      child: Row(
                        children: [
                          Container(
                            height: 90,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.5,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Colors.white),
                            child: Center(
                                child: Text(
                                  "General Session",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                          Container(
                            height: 90,
                            width: 164,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: Theme
                                .of(context)
                                .primaryColor),
                            child: Center(
                                child: Text(
                                  "2:15pm - 3:00pm",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }

  mainWidget() {
    return ListView(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        dashboardAppBar(),
        enrolledCourses(),
        context
            .watch<AppSession>()
            .user
            .userRole == UserRole.tutor ? tutoredCourses() : Container(),
        sessionCalenderView(),
        timeSlotsView()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(backgroundColor: Colors.white, body: mainWidget()),
    );
  }
}
