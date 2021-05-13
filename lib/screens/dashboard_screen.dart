import 'package:envirocar/authentication/sign_in.dart';
import 'package:envirocar/providers/bluetooth_status_provider.dart';
import 'package:envirocar/providers/gps_status_provider.dart';
import 'package:envirocar/providers/user_provider.dart';
import 'package:envirocar/services/bluetooth_status_checker.dart';
import 'package:envirocar/services/gps_status_checker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'adapter_selection_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _startTrackButtonDisabled;
  bool obdSelected, carEnabled;
  var devicesList = [];
  String _username;

  @override
  void initState() {
    _startTrackButtonDisabled = true;
    obdSelected = false;
    carEnabled = false;
    _username = '';
    setUserName();
    super.initState();
  }

  Future setUserName() async {
    if (mounted) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        _username = sharedPreferences.getString('X-User') ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<UserProvider>(
          builder: (context, provider, child) {
            return Container(
              padding: null,
              margin: null,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: provider.userLoggedIn ? 5 : 2,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.lightBlue.shade800,
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(top: 10),
                                    alignment: Alignment.topCenter,
                                    child: Image.asset('assets/images/envirocar_logo_white.png', width: 100),
                                  ),
                                  if (provider.userLoggedIn)
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 20),
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.black,
                                            radius: 32,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.lightBlue.shade800,
                                              radius: 30,
                                              child: Icon(
                                                Icons.person_sharp,
                                                color: Colors.black,
                                                size: 60,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 7),
                                            child: Text(
                                              provider.userLoggedIn ? _username : '',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                margin: EdgeInsets.only(top: 15, right: 15),
                                child: PopupMenuButton(
                                  enabled: true,
                                  offset: Offset(0, -40),
                                  child: Icon(
                                    Icons.more_vert_outlined,
                                    color: Colors.white,
                                  ),
                                  onSelected: (route) {
                                    if (provider.userLoggedIn) {
                                      final provider = Provider.of<UserProvider>(context, listen: false);
                                      provider.logout(context);
                                      setUserName();
                                    }
                                    else {
                                      Navigator.pushNamed(context, route);
                                    }
                                  },
                                  itemBuilder: (_) => [
                                    PopupMenuItem(
                                        child: Text(
                                            provider.userLoggedIn ? 'Logout' : 'Login/Register'
                                        ),
                                        value: SignIn.routeName),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: provider.userLoggedIn ? 12 : 10,
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
                                        Consumer<BluetoothStatusProvider>(
                                          builder: (context, bluetoothStatusProvider, child) => Container(
                                            child: FloatingActionButton(
                                              heroTag: 'tag1',
                                              child: Icon(Icons.bluetooth_rounded),
                                              backgroundColor: bluetoothStatusProvider.bluetoothStatus == BluetoothConnectionStatus.on ? Colors.lightBlue.shade900 : Colors.red.shade900,
                                              onPressed: () {
                                                Navigator.pushNamed(context, AdapterSelectionScreen.routeName);
                                              },
                                            ),
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
                                            heroTag: 'tag2',
                                            child: Icon(Icons.phone_android_outlined),
                                            backgroundColor: Colors.red.shade900,
                                            onPressed: () {
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
                                        Consumer<GpsStatusProvider>(
                                          builder: (context, gpsStatusProvider, child) => Container(
                                            child: FloatingActionButton(
                                              heroTag: 'tag3',
                                              child: Icon(Icons.my_location),
                                              backgroundColor: gpsStatusProvider.gpsStatus == GpsStatus.enabled ? Colors.lightBlue.shade900 : Colors.red.shade900,
                                            ),
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
                                            heroTag: 'tag4',
                                            child: Icon(Icons.directions_car),
                                            backgroundColor: carEnabled ? Colors.lightBlue.shade900 : Colors.red.shade900,
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
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: provider.userLoggedIn ? 170 : 80),
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
            );
          }
        ),
      ),
    );
  }
}