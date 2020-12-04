import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hazir_ta/models/AppSession.dart';
import 'package:hazir_ta/models/Course.dart';
import 'package:hazir_ta/models/Section.dart';
import 'package:provider/provider.dart';

class AddTutoredCourse extends StatefulWidget {
  @override
  _AddTutoredCourseState createState() => _AddTutoredCourseState();
}

class _AddTutoredCourseState extends State<AddTutoredCourse> {
  List<String> courses = [];
  List<String> sections = [];
  String selectedCourse;
  String selectedSectionCode;

  getSections() {
    context.read<AppSession>().allSections.where((element) => element.courseSection.courseName == selectedCourse).toList().forEach((element) {
      sections.add(element.sectionCode);
    });
    selectedSectionCode = sections[0];
  }

  newCourseForm() {
    Course course = context.watch<AppSession>().allCourses[0];
    print(context.watch<AppSession>().allCourses);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 50.0, right: 50.0),
            child: DropdownButton<String>(
              value: selectedCourse,
              onTap: () {
                sections.clear();
              },
              iconSize: 24,
              elevation: 16,
              onChanged: (String courseNewValue) {
                setState(() {
                  selectedCourse = courseNewValue;
                  getSections();
                });
              },
              items: courses.map<DropdownMenuItem<String>>((String coursevalue) {
                return DropdownMenuItem<String>(
                  value: coursevalue,
                  child: Text(coursevalue),
                );
              }).toList(),
            )),
        sections.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 50.0, right: 50.0),
                child: DropdownButton<String>(
                  value: selectedSectionCode,
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (String courseNewValue) {
                    setState(() {
                      selectedSectionCode = courseNewValue;
                    });
                  },
                  items: sections.map<DropdownMenuItem<String>>((String coursevalue) {
                    return DropdownMenuItem<String>(
                      value: coursevalue,
                      child: Text(coursevalue),
                    );
                  }).toList(),
                ))
            : Container(),
        Padding(
          padding: EdgeInsets.only(top: 30.0, left: 50.0, right: 50.0),
          child: FlatButton(
              onPressed: () async {
                //add course here

                Section selectedSection = context
                    .read<AppSession>()
                    .allSections
                    .where((element) => element.courseSection.courseName == selectedCourse && selectedSectionCode == element.sectionCode)
                    .toList()[0];
                await context.read<AppSession>().database.rawInsert(
                    "INSERT INTO TutoredCourse(tutored_by_user_id,tutored_section_id,approved) VALUES ( '${context.read<AppSession>().user.idUser}', '${selectedSection.sectionId}',1);");

                context.read<AppSession>().user.tutoredSections.add(selectedSection);

                context.read<AppSession>().update();
                Navigator.pop(context);
              },
              padding: EdgeInsets.zero,
              child: Material(
                elevation: 3.0,
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  height: 50.0,
                  width: double.maxFinite,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Theme.of(context).primaryColor),
                  child: Center(
                    child: Text("Add Tutored Course", style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold)),
                  ),
                ),
              )),
        )
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<String> coursesNotAvailable = [];
    context.read<AppSession>().user.enrolledSections.forEach((element) {
      coursesNotAvailable.add(element.courseSection.courseName);
    });

    context.read<AppSession>().user.tutoredSections.forEach((element) {
      coursesNotAvailable.add(element.courseSection.courseName);
    });

    context.read<AppSession>().allCourses.forEach((element) {
      if (!coursesNotAvailable.contains(element.courseName)) {
        courses.add(element.courseName);
      }
    });
    selectedCourse = courses[0];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Add a course"),
      ),
      body: newCourseForm(),
    ));
  }
}
