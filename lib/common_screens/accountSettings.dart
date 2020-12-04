import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hazir_ta/models/AppSession.dart';
import 'package:provider/provider.dart';

class AccountSettings extends StatefulWidget {
  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  String firstName;
  String lastName;
  String email;
  String image;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor));

    settingsContent() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 60.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 73.0,
                  child: CircleAvatar(
                    backgroundImage: context.watch<AppSession>().user.profileUrl == null
                        ? NetworkImage(
                            "https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg")
                        : NetworkImage("${context.watch<AppSession>().user.profileUrl}"),
                    radius: 70.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: Theme.of(context).primaryColor
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 50.0,
                  left: 50.0,
                  right: 50.0
              ),
              child: TextFormField(
                onChanged: (value) {
                  firstName = value;
                },
                initialValue: "${context
                    .watch<AppSession>()
                    .user
                    .firstName}",
                decoration: new InputDecoration(
                  labelText: "First name",
                  labelStyle: TextStyle(
                      fontSize: 18.0
                  ),
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: new BorderSide(
                      color: Theme
                          .of(context)
                          .primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 50.0,
                  left: 50.0,
                  right: 50.0
              ),
              child: TextFormField(
                onChanged: (value) {
                  lastName = value;
                },
                initialValue: "${context
                    .watch<AppSession>()
                    .user
                    .lastName}",
                decoration: new InputDecoration(
                  labelText: "Last name",
                  labelStyle: TextStyle(
                      fontSize: 18.0
                  ),
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: new BorderSide(
                      color: Theme
                          .of(context)
                          .primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 30.0,
                  left: 50.0,
                  right: 50.0
              ),
              child: TextFormField(
                onChanged: (value) {
                  email = value;
                },
                initialValue: "${context
                    .watch<AppSession>()
                    .user
                    .email}",
                decoration: new InputDecoration(
                  labelText: "Your email",
                  labelStyle: TextStyle(
                      fontSize: 18.0
                  ),
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 30.0,
                  left: 50.0,
                  right: 50.0
              ),
              child: TextFormField(
                onChanged: (value) {
                  image = value;
                },
                initialValue: "${context
                    .watch<AppSession>()
                    .user
                    .profileUrl}",
                decoration: new InputDecoration(
                  labelText: "Image URL",
                  labelStyle: TextStyle(
                      fontSize: 18.0
                  ),
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 30.0,
                  left: 50.0,
                  right: 50.0
              ),
              child: FlatButton(onPressed: () {
                context
                    .read<AppSession>()
                    .user
                    .firstName = firstName != null ? firstName : context
                    .read<AppSession>()
                    .user
                    .firstName;
                context
                    .read<AppSession>()
                    .user
                    .lastName = lastName != null ? lastName : context
                    .read<AppSession>()
                    .user
                    .lastName;
                context
                    .read<AppSession>()
                    .user
                    .email = email != null ? email : context
                    .read<AppSession>()
                    .user
                    .email;
                context
                    .read<AppSession>()
                    .user
                    .profileUrl = image != null ? image : context
                    .read<AppSession>()
                    .user
                    .profileUrl;
                context
                    .read<AppSession>()
                    .user
                    .updateUserDatabase(context
                    .read<AppSession>()
                    .database);
                context.read<AppSession>().update();
                Fluttertoast.showToast(
                    msg: "User Updated! ",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    fontSize: 16.0
                );
              },
                  padding: EdgeInsets.zero,
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      height: 50.0,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Theme
                              .of(context)
                              .primaryColor
                      ),
                      child: Center(
                        child: Text("Save changes",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                    ),
                  )
              ),
            )
          ],
        ),
      );
    }

    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text("Account settings"),
          ),
          body: settingsContent(),
        )
    );
  }
}
