import 'package:envirocar/authentication/sign_in.dart';
import 'package:envirocar/authentication/sign_up.dart';
import 'package:envirocar/screens/home_screen.dart';
import 'package:envirocar/screens/track_details.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  SignIn.routeName: (ctx) => SignIn(),
  SignUp.routeName: (ctx) => SignUp(),
  HomeScreen.routeName: (ctx) => HomeScreen(),
  TrackDetails.routeName: (ctx) => TrackDetails(),
};