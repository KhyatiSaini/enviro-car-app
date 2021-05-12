import 'dart:async';
import 'package:geolocator/geolocator.dart';

enum gpsStatus {
  enabled,
  disabled
}

class GPSStatusChecker {

  static const Duration DEFAULT_INTERVAL = Duration(seconds: 5);

  factory GPSStatusChecker() => _gpsStatusChecker;
  GPSStatusChecker._() {
    _statusController.onListen = () {
      _sendStatusUpdates();
    };

    _statusController.onCancel = () {
      _timer.cancel();
      _lastStatus = null;
    };
  }

  static final GPSStatusChecker _gpsStatusChecker = GPSStatusChecker._();

  Future<gpsStatus> get locationIsEnabled async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    return serviceEnabled ? gpsStatus.enabled : gpsStatus.disabled;
  }

  Duration checkInterval = DEFAULT_INTERVAL;

  _sendStatusUpdates([Timer timer]) async {
    _timer?.cancel();
    timer?.cancel();

    var _currentStatus = await locationIsEnabled;

    if (_currentStatus != _lastStatus && _statusController.hasListener) {
      _statusController.add(_currentStatus);
    }

    if (!_statusController.hasListener)
      return;

    _timer = Timer(checkInterval, _sendStatusUpdates);

    // update last status
    _lastStatus = _currentStatus;

  }

  gpsStatus _lastStatus;
  Timer _timer;

  // ignore: close_sinks
  StreamController<gpsStatus> _statusController = StreamController.broadcast();

  Stream<gpsStatus> get onStatusChange => _statusController.stream;

  bool get hasListener => _statusController.hasListener;

}