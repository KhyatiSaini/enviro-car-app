import 'package:envirocar/authentication/sign_in.dart';
import 'package:envirocar/routes/routes.dart';
import 'package:flutter/material.dart';

import './authentication/sign_up.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enviro Car',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        unselectedWidgetColor: Colors.grey[200]
      ),
      home: SignUp(),
      routes: routes,
    );
  }
}
