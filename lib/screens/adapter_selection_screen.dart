import 'package:envirocar/providers/bluetooth_status_provider.dart';
import 'package:envirocar/screens/home_screen.dart';
import 'package:envirocar/services/bluetooth_status_checker.dart';
import 'package:envirocar/utilities/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:system_setting/system_setting.dart';

class AdapterSelectionScreen extends StatelessWidget {
  static String routeName = '/adapter_selection_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdapterSelectionScreenPage(),
    );
  }
}

class AdapterSelectionScreenPage extends StatefulWidget {
  @override
  _AdapterSelectionScreenPageState createState() => _AdapterSelectionScreenPageState();
}

class _AdapterSelectionScreenPageState extends State<AdapterSelectionScreenPage> {

  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> bluetoothDevices = [];
  bool reload = false;
  int selected;

  @override
  void initState() {
    selected = -1;
    startScan();
    super.initState();
  }

  /// function to determine bluetooth connection status
  Future<bool> determineBluetoothConnectionStatus() async {
    return await flutterBlue.isOn;
  }

  /// function to start scan
  void startScan() async {
    bool bluetoothStatus = await determineBluetoothConnectionStatus();
    if (bluetoothStatus)
      scanAndPopulateList();
  }

  /// function to populate list [bluetoothDevices] when devices are found
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

  /// function to stop scan
  void stopScan() {
    flutterBlue.stopScan();
  }

  /// function to add device to list
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

  @override
  Widget build(BuildContext context) {

    final bluetoothStatus = Provider.of<BluetoothStatusProvider>(context).bluetoothStatus;
    if (bluetoothStatus == BluetoothConnectionStatus.on)
      startScan();

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
                          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
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
                                bluetoothStatus == BluetoothConnectionStatus.on ? 'Bluetooth On' : 'Bluetooth Off',
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
                                value: bluetoothStatus == BluetoothConnectionStatus.on,
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
                  child: bluetoothStatus == BluetoothConnectionStatus.on ?
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
                                  showSnackBar(context, 'Bluetooth discovery started.');
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
}