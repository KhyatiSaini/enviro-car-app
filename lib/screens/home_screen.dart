import 'package:envirocar/screens/adapter_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _startTrackButtonDisabled;
  bool bluetoothBg, obdBg, gpsBg, carBg;
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  FlutterBlue _flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devicesList = [];

  @override
  void initState() {
    _startTrackButtonDisabled = false;
    bluetoothBg = false;
    obdBg = false;
    gpsBg = false;
    carBg = false;
    determineGpsStatus();
    determineBluetoothConnectionStatus();
    super.initState();
  }

  Future determineGpsStatus() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    setState(() {
      gpsBg = serviceEnabled;
      print('location status --> $serviceEnabled');
    });
  }

  Future determineBluetoothConnectionStatus() async {
    bool bluetoothEnabled = await _flutterBlue.isOn;
    setState(() {
      bluetoothBg = bluetoothEnabled;
      print('bluetooth status --> $bluetoothEnabled');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.speed, color: Colors.grey),
            title: Text('Dashboard', style: TextStyle(color: Colors.grey)),
            backgroundColor: Colors.lightBlue.shade900,
            activeIcon: Icon(Icons.speed, color: Colors.lightBlue.shade900),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_road_outlined, color: Colors.grey),
            title: Text('Tracks', style: TextStyle(color: Colors.grey)),
            backgroundColor: Colors.lightBlue.shade900,
            activeIcon: Icon(Icons.speed, color: Colors.lightBlue.shade900),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz, color: Colors.grey),
            title: Text('Others', style: TextStyle(color: Colors.grey)),
            backgroundColor: Colors.lightBlue.shade900,
            activeIcon: Icon(Icons.speed, color: Colors.lightBlue.shade900),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: null,
          margin: null,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.lightBlue.shade800,
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(top: 10),
                            alignment: Alignment.topCenter,
                            child: Image.asset('assets/images/envirocar_logo_white.png', width: 100),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.only(top: 15, right: 15),
                            child: PopupMenuButton(
                              offset: Offset(0, -40),
                              child: Icon(
                                Icons.more_vert_outlined,
                                color: Colors.white,
                              ),
                              onSelected: (index) {
                                print('selected');
                              },
                              itemBuilder: (context) {
                                return List.generate(1, (index) {
                                  return PopupMenuItem(
                                    child: Text('Login/Register'),
                                  );
                                });
                              },
                            ),
                          ),
                        ],
                      ),
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
                            margin: EdgeInsets.fromLTRB(60, 60, 60, 20),
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
                                        backgroundColor: bluetoothBg ? Colors.lightBlue.shade900 : Colors.red.shade900,
                                        onPressed: () {
                                          // TODO: navigate to adapter selection screen
                                          Navigator.pushNamed(context, AdapterSelectionScreen.routeName);
                                        },
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
                                        backgroundColor: Colors.red.shade900,
                                        onPressed: () {
                                          // TODO: navigate to adapter selection screen
                                          Navigator.pushNamed(context, AdapterSelectionScreen.routeName);
                                        },
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
                                        backgroundColor: gpsBg ? Colors.lightBlue.shade900 : Colors.red.shade900,
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
                                        backgroundColor: carBg ? Colors.lightBlue.shade900 : Colors.red.shade900,
                                        onPressed: () {
                                          // TODO: navigate to car selection screen
                                        },
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
                          SizedBox(height: 10),
                          Container(
                            height: 60,
                            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    spreadRadius: 0.5,
                                    blurRadius: 0.5,
                                    offset: Offset(0, 1)
                                ),
                              ],
                            ),
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    color: Colors.lightBlue.shade900,
                                    child: Icon(
                                      Icons.bluetooth_audio,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            'No OBD-II adapter selected',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            'Click here to select one'
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Spacer(),
                                  Spacer(),
                                  Spacer(),
                                  Container(
                                    height: 60,
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.lightBlue.shade900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.7),
                                  spreadRadius: 0.5,
                                  blurRadius: 0.5,
                                  offset: Offset(0, 1)
                                ),
                              ],
                            ),
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    color: Colors.lightBlue.shade900,
                                    child: Icon(
                                      Icons.directions_car,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            'No car type selected',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                              'Click here to select one'
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Spacer(),
                                  Spacer(),
                                  Spacer(),
                                  Container(
                                    height: 60,
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.lightBlue.shade900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              onPressed: _startTrackButtonDisabled ? null : () {

                              },
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                              child: Text(
                                'start track'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17
                                ),
                              ),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              disabledColor: Colors.grey,
                              color: Colors.lightBlue.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 80,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
                padding: EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 0.5,
                      blurRadius: 0.5,
                      offset: Offset(0, 1)
                    ),
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              '0',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              'Total tracks',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              '0 km',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              'Total distance',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              '00:00 h',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              'Total Duration',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}