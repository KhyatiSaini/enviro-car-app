import 'package:envirocar/services/bluetooth_status_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:system_setting/system_setting.dart';
import 'package:toast/toast.dart';

class AdapterSelectionScreen extends StatefulWidget {
  static String routeName = '/adapter_selection_screen';

  @override
  _AdapterSelectionScreenState createState() => _AdapterSelectionScreenState();
}

class _AdapterSelectionScreenState extends State<AdapterSelectionScreen> {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> bluetoothDevices = [];
  bool bluetoothIsOn = false, reload = false;
  int selected;

  @override
  void initState() {
    selected = -1;
    determineBluetoothConnectionStatus().then((status) => {
      if (status) {
        scanAndPopulateList(),
        setState(() {
          bluetoothIsOn = true;
        })
      }
    });
    super.initState();
  }

  Future<bool> determineBluetoothConnectionStatus() async {
    return await flutterBlue.isOn;
  }

  void scanAndPopulateList() {
    flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        addDeviceToList(device);
      }
    });

    flutterBlue.scanResults
        .listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        addDeviceToList(result.device);
        print('${result.device}');
      }
    });

    flutterBlue.startScan();
  }

  void stopScan() {
    flutterBlue.stopScan();
  }

  void addDeviceToList(final BluetoothDevice device) {
    if (!bluetoothDevices.contains(device)) {
      setState(() {
        bluetoothDevices.add(device);
      });
    }
  }

  @override
  void dispose() {
    stopScan();
    super.dispose();
  }

  // Future<void> customEnableBT(BuildContext context) async {
  //   BluetoothEnable.customBluetoothRequest(
  //       context,
  //       " ",
  //       true,
  //       "An app wants to turn bluetooth on",
  //       "Decline",
  //       "Allow",
  //       10.0,
  //       true)
  //       .then((value) {
  //     print(value);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<BluetoothConnectionStatus>(
        stream: BluetoothStatusChecker().onStatusChange,
        builder: (context, snapshot) {
          return SafeArea(
            child: Container(
              padding: null,
              margin: null,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.lightBlue.shade800,
                        child: Stack(
                          children: [
                            GestureDetector(
                              child: Container(
                                margin: EdgeInsets.only(left: 20, top: 20),
                                alignment: Alignment.topLeft,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.only(top: 20),
                              child: Text(
                                'OBD - II Adapter Selection',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Spacer(),
                                  Container(
                                    child: Text(
                                      snapshot.data == BluetoothConnectionStatus.on ? 'Bluetooth On' : 'Bluetooth Off',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Spacer(),
                                  Spacer(),
                                  Container(
                                    child: Switch(
                                      value: snapshot.data == BluetoothConnectionStatus.on,
                                      onChanged: (status) async {
                                        SystemSetting.goto(SettingTarget.BLUETOOTH);
                                        // determineBluetoothConnectionStatus().then((value) {
                                        //   setState(() {
                                        //     bluetoothIsOn = value;
                                        //   });
                                        // });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 11,
                      child: Container(
                        child: snapshot.data == BluetoothConnectionStatus.on ?
                        Container(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Available',
                                        style: TextStyle(
                                          color: Colors.lightBlue.shade800,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Visibility(
                                      visible: true,
                                      child: Container(
                                        child: SizedBox(
                                          height: 18,
                                          width: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: new AlwaysStoppedAnimation<Color>(Colors.lightBlue.shade800),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 40),
                                        child: Icon(
                                          Icons.refresh_outlined,
                                          color: Colors.lightBlue.shade800,
                                        ),
                                      ),
                                      onTap: () {
                                        Toast.show(
                                          "Bluetooth discovery started.",
                                          context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.BOTTOM,
                                          backgroundRadius: 4,
                                        );
                                        setState(() {
                                          reload = true;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemBuilder: (BuildContext context, index) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(horizontal: 5),
                                      child: ListTile(
                                        title: Text(
                                          (bluetoothDevices[index].name == null || bluetoothDevices[index].name.trim().length == 0)? 'Unknown Device' : bluetoothDevices[index].name,
                                        ),
                                        subtitle: Text(
                                          bluetoothDevices[index].id.toString()
                                        ),
                                        trailing: Radio(
                                          activeColor: Colors.lightBlue.shade800,
                                          value: index,
                                          groupValue: selected,
                                          onChanged: (value) {
                                            setState(() {
                                              selected = value;
                                            });
                                          }
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: bluetoothDevices.length,
                                ),
                              ),
                            ],
                          ),
                        ) :
                        Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.topCenter,
                          child: Text(
                            'Bluetooth is disabled.',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}