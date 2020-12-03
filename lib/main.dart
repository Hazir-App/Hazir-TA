import 'package:flutter/material.dart';
import 'package:flutter_sqflite_manager/flutter_sqflite_manager.dart';
import 'package:hazir_ta/common_screens/loginScreen.dart';
import 'package:hazir_ta/models/AppSession.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AppSession>(
      create: (_) => AppSession(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(101, 40, 110, 1),
        accentColor: Color.fromRGBO(108, 60, 99, 1),
        primaryColorLight: Color.fromRGBO(213, 196, 190, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SqfliteManager(
        database: context.watch<AppSession>().database,
        // Update rowsPerPage parameter to avoid scrolling in different screen sizes
        rowsPerPage: 6,
        enable: true,
        child: LoginScreen(),
      ),
    );
  }
}
