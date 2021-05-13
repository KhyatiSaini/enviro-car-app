import 'package:envirocar/services/bluetooth_status_checker.dart';
import 'package:flutter/foundation.dart';

class BluetoothStatusProvider extends ChangeNotifier {

  BluetoothConnectionStatus bluetoothStatus;

  BluetoothStatusProvider() {
    bluetoothStatus = BluetoothConnectionStatus.off;
    updateBluetoothStatus();
  }

  void updateBluetoothStatus() {
    BluetoothStatusChecker().onStatusChange.listen((status) {
      bluetoothStatus = status;
      notifyListeners();
    });
  }

  BluetoothConnectionStatus get bluetoothState => bluetoothStatus;

}