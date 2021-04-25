import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.speed, color: Colors.grey),
            title: Text('Dashboard', style: TextStyle(color: Colors.lightBlue.shade900)),
            backgroundColor: Colors.lightBlue.shade800,
            activeIcon: Icon(Icons.speed, color: Colors.lightBlue.shade800),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_road_outlined, color: Colors.grey),
              title: Text('Tracks', style: TextStyle(color: Colors.lightBlue.shade900)),
              backgroundColor: Colors.lightBlue.shade800
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz, color: Colors.grey),
              title: Text('Others', style: TextStyle(color: Colors.lightBlue.shade900)),
              backgroundColor: Colors.lightBlue.shade800
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: null,
          margin: null,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.lightBlue.shade800,
                ),
              ),
              Expanded(
                flex: 10,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.fromLTRB(60, 30, 60, 20),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue.shade900,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Recording settings',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: FloatingActionButton(
                                    child: Icon(Icons.bluetooth_rounded),
                                    backgroundColor: Colors.lightBlue.shade900,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'Bluetooth',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: FloatingActionButton(
                                    child: Icon(Icons.phone_android_outlined),
                                    backgroundColor: Colors.lightBlue.shade900,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'OBD',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: FloatingActionButton(
                                    child: Icon(Icons.my_location),
                                    backgroundColor: Colors.lightBlue.shade900,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'GPS',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: FloatingActionButton(
                                    child: Icon(Icons.directions_car),
                                    backgroundColor: Colors.lightBlue.shade900,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'Car',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}