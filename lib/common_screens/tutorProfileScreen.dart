import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hazir_ta/common_screens/rateTutor.dart';
import 'package:hazir_ta/models/User.dart';
import 'package:hazir_ta/tutor_screens/tutorSessionInfo.dart';
import 'package:table_calendar/table_calendar.dart';
class TutorProfile extends StatefulWidget {
  User user;
  Function onUpdate;
  TutorProfile({this.user,this.onUpdate});
  @override
  _TutorProfileState createState() => _TutorProfileState();
}

class _TutorProfileState extends State<TutorProfile> {

  CalendarController _calendarController = CalendarController();

  profileAppBar() {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 310),
      child: Container(
          height: 310,
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0
                        ),
                      ),
                      Text("${widget.user.firstName + " " + widget.user.lastName}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                      icon: Icon(
                          Icons.forward_to_inbox_sharp,
                          color: Colors.white,
                      ),
                      onPressed: () {}
                  )
                ],
              ),
              SizedBox(height: 10.0,),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 53,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: widget.user.profileUrl == null
                      ? NetworkImage(
                      "https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg")
                      : NetworkImage("${widget.user.profileUrl}"),
                ),
              ),
              SizedBox(height: 10.0,),
              Text("Average Ratings",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0
                ),
              ),
              SizedBox(height: 5.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_half,
                    color: Colors.white,
                    size: 18,
                  ),
                  Center(
                    child: Text("${widget.user.averageRating.toStringAsFixed(1)}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15.0,),

            ],
          ),
        ),
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
            ],
          ),
        ),
        widget.user
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
                itemCount: widget.user
                    .tutoredSections
                    .length,
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RateTutor(user: widget.user,course: widget.user.tutoredSections[index].courseSection,updateUser: (User u){setState(() {
                            setState(() {
                              widget.user=u;
                            });
                            widget.onUpdate(u);
                          });},)),
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
                                  "${widget.user
                                      .tutoredSections[index].courseSection.courseCode}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(letterSpacing: 1.0, color: Theme
                                      .of(context)
                                      .primaryColor, fontWeight: FontWeight.bold, fontSize: 22),
                                ),
                                Text(
                                  "${widget.user
                                      .tutoredSections[index].courseSection.courseName}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(letterSpacing: 1.0, color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                                Text(
                                  "${widget.user
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
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text("All Sesssions",
            style: TextStyle(
                letterSpacing: 2.0,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 18
            ),),
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


  timeSlotsView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Text("Timeslots",
            style: TextStyle(
                letterSpacing: 2.0,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 18
            ),),
        ),
        Container(
          child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0
                  ),
                  child: InkWell(
                    onTap: (){
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
                            width: 280,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.white
                            ),
                            child: Center(
                                child: Text("General Session",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                          ),
                          Container(
                            height: 90,
                            width: 164,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Theme.of(context).primaryColor
                            ),
                            child: Center(
                                child: Text("2:15pm - 3:00pm",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: profileAppBar(),
          body: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              vertical: 20.0
            ),
            children: [
              tutoredCourses(),
              sessionCalenderView(),
              timeSlotsView()
            ],
          ),
        )
    );
  }
}
