import 'package:envirocar/utilities/api_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackDetails extends StatefulWidget {
  static String routeName = '/track_details';
  @override
  _TrackDetailsState createState() => _TrackDetailsState();
}

class _TrackDetailsState extends State<TrackDetails> {
  GoogleMapController mapController;
  final LatLng latLng = const LatLng(31.468515836335204, 76.27084843947246);
  final List<Marker> markers = [];
  PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polyLines = {};
  List<LatLng> polyLineCoordinates = [];
  bool showAppBar = false;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
        setState(() {
          showAppBar = false;
        });
      }

      if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        setState(() {
          showAppBar = true;
        });
      }
    });

    createPolyLines(LatLng(31.468515836335204, 76.27084843947246), LatLng(31.46487223893297, 76.30082129528897));
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.removeListener(() {});
    scrollController.dispose();
  }

  void _onMapCreated(GoogleMapController googleMapController) {
    mapController = googleMapController;

    setState(() {
      markers.clear();

      markers.add(
        new Marker(
          markerId: MarkerId(
              LatLng(31.468515836335204, 76.27084843947246).toString()),
          draggable: false,
          infoWindow: InfoWindow(title: 'Una, Himachal Pradesh'),
          position: LatLng(31.468515836335204, 76.27084843947246),
        ),
      );

      markers.add(
        new Marker(
          markerId: MarkerId(
              LatLng(31.46487223893297, 76.30082129528897).toString()),
          draggable: false,
          infoWindow: InfoWindow(title: 'Rakkar Colony, Una'),
          position: LatLng(31.46487223893297, 76.30082129528897),
        ),
      );
    });
  }

  // function to create polyLines between two places to show the route
  Future createPolyLines(LatLng start, LatLng destination) async {
    polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving
    );

    // adding the coordinates to the list
    if (result.points.isNotEmpty) {
      print("hey");
      result.points.forEach((PointLatLng point) {
        polyLineCoordinates.add(LatLng(point.latitude,  point.longitude));
      });
    }

    PolylineId polylineId = PolylineId("1");

    // initializing polyline
    Polyline polyline = Polyline(
      visible: true,
      polylineId: polylineId,
      color: Colors.red,
      points: polyLineCoordinates,
      width: 3
    );

    setState(() {
      polyLines[polylineId] = polyline;
    });

    print(polyLines[1].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            child: Column(
              children: [
                AnimatedContainer(
                  child: AppBar(
                    title: Text('Track Apr 15, 2021 08:15:06'),
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.lightBlue.shade700,
                    foregroundColor: Colors.white,
                    leading: Icon(
                        Icons.arrow_back
                    ),
                  ),
                  height: showAppBar ? 60 : 0.0,
                  duration: Duration(milliseconds: 500),
                ),
                Visibility(
                  visible: !showAppBar,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 350,
                        color: Colors.lightBlue.shade700,
                        child: GoogleMap(
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: latLng,
                            zoom: 10,
                          ),
                          markers: markers.toSet(),
                          polylines: polyLines.values.toSet(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 30),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.withOpacity(0.4),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(5),
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.grey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Track Apr 15, 2021 08:15:06',
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Your Track with Honda Civic on Monday.',
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: Text(
                                      '00:18:10',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.lightBlue.shade700,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'Duration',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(right: 10, top: 10),
                                    child: Text(
                                      '5.04 km',
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.lightBlue.shade700,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'Distance',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 18),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Colors.grey[400],
                            thickness: 1.2,
                          ),
                        ),
                        Container(
                          child: ListTile(
                            dense: true,
                            title: Text(
                              'Car',
                            ),
                            leading: Icon(
                              Icons.directions_car,
                              color: Colors.grey.shade600,
                            ),
                            trailing: Container(
                              width: 140,
                              child: Text(
                                'Honda - Civic 2007, 1798 cm, Gasoline',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Colors.grey
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: ListTile(
                            dense: true,
                            title: Text(
                              'Start',
                            ),
                            leading: Icon(
                              Icons.timer_outlined,
                              color: Colors.grey.shade600,
                            ),
                            trailing: Container(
                              width: 140,
                              child: Text(
                                'Apr 5, 2021 08:15:06',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.grey
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: ListTile(
                            dense: true,
                            title: Text(
                              'End',
                            ),
                            leading: Icon(
                              Icons.timelapse,
                              color: Colors.grey.shade600,
                            ),
                            trailing: Container(
                              width: 140,
                              child: Text(
                                'Apr 5, 2021 08:33:16',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.grey
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: ListTile(
                            dense: true,
                            title: Text(
                              'Speed',
                            ),
                            leading: Icon(
                              Icons.speed_rounded,
                              color: Colors.grey.shade600,
                            ),
                            trailing: Container(
                              child: Text(
                                '16.64 km/h',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.grey
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: ListTile(
                            dense: true,
                            title: Text(
                              'Number of Stops',
                            ),
                            leading: Icon(
                              Icons.bus_alert,
                              color: Colors.grey.shade600,
                            ),
                            trailing: Container(
                              child: Text(
                                '1 stops',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.grey
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: ListTile(
                            dense: true,
                            title: Text(
                              'Total stop time',
                            ),
                            leading: Icon(
                              Icons.time_to_leave_outlined,
                              color: Colors.grey.shade600,
                            ),
                            trailing: Container(
                              child: Text(
                                '30 m 0 s',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.grey
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                          child: Text(
                            '** Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 145),
              ],
            ),
          ),
        ),
      ),
    );
  }
}