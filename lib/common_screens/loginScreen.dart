import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hazir_ta/models/AppSession.dart';
import 'package:hazir_ta/models/User.dart';
import 'package:hazir_ta/tutor_screens/dashboard.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String id;
  String password;

  profileAppBar() {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 310),
      child: Container(
        height: 300,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Hazir",
              style: TextStyle(letterSpacing: 4, fontSize: 64, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              "Teacher Assistant",
              style: TextStyle(fontSize: 21, color: Colors.white),
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              "Login",
              style: TextStyle(letterSpacing: 1, fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  loginForm() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 80.0, left: 50.0, right: 50.0),
          child: TextFormField(
            onChanged: (value) {
              id = value;
            },
            autofocus: false,
            readOnly: false,
            decoration: new InputDecoration(
              hintText: "e.g ab01234",
              labelText: "HU ID",
              labelStyle: TextStyle(fontSize: 18.0),
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
                borderSide: new BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              enabledBorder: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
                borderSide: new BorderSide(color: Theme.of(context).primaryColor, width: 2),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 50.0, right: 50.0),
          child: TextFormField(
            onChanged: (value) {
              password = value;
            },
            autofocus: false,
            readOnly: false,
            obscureText: true,
            decoration: new InputDecoration(
              hintText: "Your HU password",
              labelText: "Password",
              labelStyle: TextStyle(fontSize: 18.0),
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
                borderSide: new BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              enabledBorder: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
                borderSide: new BorderSide(color: Theme.of(context).primaryColor, width: 2),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 30.0,
            left: 50.0,
            right: 50.0,
          ),
          child: FlatButton(
              onPressed: () async {
                context.read<AppSession>().user=null;
                await context.read<AppSession>().loginUser(id, password);
                if (context.read<AppSession>().user != null) {
                  if (context.read<AppSession>().user.userRole == UserRole.student) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TutorDashboard()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TutorDashboard()),
                    );
                  }
                }
              },
              padding: EdgeInsets.zero,
              child: Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  height: 50.0,
                  width: double.maxFinite,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Theme.of(context).primaryColor),
                  child: Center(
                    child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold)),
                  ),
                ),
              )),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        appBar: profileAppBar(),
        body: context.watch<AppSession>().database == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : loginForm(),
      ),
    );
  }
}
