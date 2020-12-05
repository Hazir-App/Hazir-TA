import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hazir_ta/models/AppSession.dart';
import 'package:hazir_ta/models/Session.dart';
import 'package:provider/provider.dart';

class TutorSessionInfoScreen extends StatefulWidget {
  Session session;

  TutorSessionInfoScreen({Key key,this.session}) : super(key: key);

  @override
  _TutorSessionInfoScreenState createState() => _TutorSessionInfoScreenState();
}

class _TutorSessionInfoScreenState extends State<TutorSessionInfoScreen> {
  
  @override
  initState()  {
    super.initState();
    // print(widget.session.courseId);
    // widget.session.loadMoreInfo(context.read<AppSession>().database, context.read<AppSession>().user.idUser,context.read<AppSession>().user.userIntRole);

  }

  infoContent() {
    return ListView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 20.0
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TextFormField(
            initialValue: widget.session.sessionName,
            autofocus: false,
            readOnly: true,
            decoration: new InputDecoration(
              labelText: "Session type",
              labelStyle: TextStyle(
                  fontSize: 18.0
              ),
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
                borderSide: new BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              enabledBorder: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
                borderSide: new BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TextFormField(
            initialValue: widget.session.courseName,
            autofocus: false,
            readOnly: true,
            decoration: new InputDecoration(
              labelText: "Course",
              labelStyle: TextStyle(
                  fontSize: 18.0
              ),
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
                borderSide: new BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              enabledBorder: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
                borderSide: new BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TextFormField(
            initialValue: widget.session.sessionDate,
            autofocus: false,
            readOnly: true,
            decoration: new InputDecoration(
              labelText: "Date",
              labelStyle: TextStyle(
                  fontSize: 18.0
              ),
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
                borderSide: new BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              enabledBorder: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
                borderSide: new BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: 200.0,
                child: TextFormField(
                  initialValue: widget.session.sessionStartTime,
                  autofocus: false,
                  readOnly: true,
                  decoration: new InputDecoration(
                    labelText: "Start time",
                    labelStyle: TextStyle(
                        fontSize: 18.0
                    ),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                width: 200,
                child: TextFormField(
                  initialValue: widget.session.sessionEndTime,
                  autofocus: false,
                  readOnly: true,
                  decoration: new InputDecoration(
                    labelText: "End time",
                    labelStyle: TextStyle(
                        fontSize: 18.0
                    ),
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TextFormField(
            initialValue: "Online: Zoom",
            autofocus: false,
            readOnly: true,
            decoration: new InputDecoration(
              labelText: "Medium",
              labelStyle: TextStyle(
                  fontSize: 18.0
              ),
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
                borderSide: new BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              enabledBorder: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
                borderSide: new BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
            height: 250,
            child: TextFormField(
              maxLength: 300,
              maxLines: 100,
              initialValue: "I will be reviewing ERD and normalization,",
              autofocus: false,
              readOnly: true,
              decoration: new InputDecoration(
                labelText: "Notes",
                labelStyle: TextStyle(
                    fontSize: 18.0
                ),
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  borderSide: new BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                enabledBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  borderSide: new BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2
                  ),
                ),
              ),
            ),
          ),
        ),


      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Session info"),
          ),
          body: infoContent(),
        )
    );
  }
}
