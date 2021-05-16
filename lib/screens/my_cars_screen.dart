import 'package:envirocar/screens/car_selection_screen.dart';
import 'package:envirocar/theme/colors_cario.dart';
import 'package:flutter/material.dart';

class MyCarsScreen extends StatelessWidget {
  static String routeName = '/my_cars_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CarioColors.carioColorPrimary,
        centerTitle: true,
        title: Image.asset('assets/images/envirocar_logo_white.png', width: 100),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'My Cars',
              style: TextStyle(
                color: CarioColors.carioColorPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: CarioColors.carioColorPrimaryDark,
        onPressed: () {
          Navigator.pushNamed(context, CarSelectionScreen.routeName);
        },
      ),
    );
  }
}