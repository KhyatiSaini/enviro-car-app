import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothStatusProvider with ChangeNotifier {
  FlutterBlue _flutterBlue = FlutterBlue.instance;
  bool bluetoothON;

  Future determineBluetoothConnectionStatus() async {
    bool bluetoothEnabled = await _flutterBlue.isOn;
    bluetoothON = bluetoothEnabled;
    print('bluetooth status --> $bluetoothON');
    notifyListeners();
  }

  bool get bluetoothStatus => bluetoothON;
}