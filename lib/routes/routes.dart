import 'package:envirocar/authentication/sign_in.dart';
import 'package:envirocar/authentication/sign_up.dart';
import 'package:envirocar/screens/adapter_selection_screen.dart';
import 'package:envirocar/screens/car_selection_screen.dart';
import 'package:envirocar/screens/home_screen.dart';
import 'package:envirocar/screens/my_cars_screen.dart';
import 'package:envirocar/screens/others_screen.dart';
import 'package:envirocar/screens/track_details.dart';
import 'package:envirocar/screens/track_upload_screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  SignIn.routeName: (ctx) => SignIn(),
  SignUp.routeName: (ctx) => SignUp(),
  HomeScreen.routeName: (ctx) => HomeScreen(),
  TrackDetails.routeName: (ctx) => TrackDetails(),
  AdapterSelectionScreen.routeName: (ctx) => AdapterSelectionScreen(),
  TrackUploadScreen.routeName: (ctx) => TrackUploadScreen(),
  OthersScreen.routeName: (ctx) => OthersScreen(),
  MyCarsScreen.routeName: (ctx) => MyCarsScreen(),
  CarSelectionScreen.routeName: (ctx) => CarSelectionScreen(),
};