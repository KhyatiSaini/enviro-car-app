import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';

enum BluetoothConnectionStatus {
  on,
  off
}

class BluetoothStatusChecker {

  static const Duration DEFAULT_INTERVAL = Duration(seconds: 2);

  factory BluetoothStatusChecker() => _bluetoothStatusChecker;
  BluetoothStatusChecker._() {
    _statusController.onListen = () {
      _sendStatusUpdates();
    };

    _statusController.onCancel = () {
      _timer?.cancel();
      _lastStatus = null;
    };
  }

  static final BluetoothStatusChecker _bluetoothStatusChecker = BluetoothStatusChecker._();

  /// function to get bluetooth connection status
  Future<BluetoothConnectionStatus> get connectionStatus async {
    FlutterBlue flutterBlue = FlutterBlue.instance;
    bool hasConnection = await flutterBlue.isOn;
    return hasConnection ? BluetoothConnectionStatus.on : BluetoothConnectionStatus.off;
  }

  Duration checkInterval = DEFAULT_INTERVAL;

  /// function to send bluetooth status updates
  _sendStatusUpdates([Timer timer]) async {
    _timer?.cancel();
    timer?.cancel();

    var _currentStatus = await connectionStatus;

    if (_currentStatus != _lastStatus && _statusController.hasListener) {
      _statusController.add(_currentStatus);
    }

    if (!_statusController.hasListener)
      return;

    _timer = Timer(checkInterval, _sendStatusUpdates);

    // update last status
    _lastStatus = _currentStatus;

  }

  BluetoothConnectionStatus _lastStatus;
  Timer _timer;

  // ignore: close_sinks
  StreamController<BluetoothConnectionStatus> _statusController = StreamController.broadcast();

  /// function to return stream of bluetooth connection status
  Stream<BluetoothConnectionStatus> get onStatusChange => _statusController.stream;

  /// function to check whether the bluetooth connection status stream has listeners
  bool get hasListeners => _statusController.hasListener;
}