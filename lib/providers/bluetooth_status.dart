import 'dart:async';
import 'package:envirocar/services/bluetooth_status_checker.dart';
import 'package:flutter/foundation.dart';

class BluetoothStatusProvider extends ChangeNotifier {
  // ignore: close_sinks
  StreamController<BluetoothConnectionStatus> statusStreamController = StreamController<BluetoothConnectionStatus>();

  BluetoothStatusProvider() {
    BluetoothStatusChecker().onStatusChange.listen((bluetoothStatus) {
      statusStreamController.add(bluetoothStatus);
    });
  }
  // FlutterBlue _flutterBlue = FlutterBlue.instance;
  // bool bluetoothON;
  //
  // BluetoothStatusProvider() {
  //   bluetoothON = false;
  //   getBluetoothStatus();
  // }
  //
  // Future determineBluetoothConnectionStatus() async {
  //   bool bluetoothEnabled = await _flutterBlue.isOn;
  //   bluetoothON = bluetoothEnabled;
  //   print('bluetooth status (provider) -->  $bluetoothON');
  //   notifyListeners();
  // }
  //
  // Future getBluetoothStatus() async {
  //   bool bluetoothEnabled = await _flutterBlue.isOn;
  //   bluetoothON = bluetoothEnabled;
  //   notifyListeners();
  // }
  //
  // get bluetoothStatus => bluetoothON;
}