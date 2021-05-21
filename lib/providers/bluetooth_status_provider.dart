import 'package:envirocar/services/bluetooth_status_checker.dart';
import 'package:flutter/foundation.dart';

class BluetoothStatusProvider extends ChangeNotifier {

  BluetoothConnectionStatus bluetoothStatus;

  BluetoothStatusProvider() {
    bluetoothStatus = BluetoothConnectionStatus.off;
    updateBluetoothStatus();
  }

  /// function to update bluetooth status upon listening status updates
  void updateBluetoothStatus() {
    BluetoothStatusChecker().onStatusChange.listen((status) {
      bluetoothStatus = status;
      notifyListeners();
    });
  }

  /// function to get [bluetoothState]
  BluetoothConnectionStatus get bluetoothState => bluetoothStatus;

}