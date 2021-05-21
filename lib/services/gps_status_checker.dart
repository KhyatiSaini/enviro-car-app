import 'dart:async';
import 'package:geolocator/geolocator.dart';

enum GpsStatus {
  enabled,
  disabled
}

class GpsStatusChecker {

  static const Duration DEFAULT_INTERVAL = Duration(seconds: 2);

  factory GpsStatusChecker() => _gpsStatusChecker;
  GpsStatusChecker._() {
    _statusController.onListen = () {
      _sendStatusUpdates();
    };

    _statusController.onCancel = () {
      _timer.cancel();
      _lastStatus = null;
    };
  }

  static final GpsStatusChecker _gpsStatusChecker = GpsStatusChecker._();

  /// function to get location status
  Future<GpsStatus> get locationIsEnabled async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    return serviceEnabled ? GpsStatus.enabled : GpsStatus.disabled;
  }

  Duration checkInterval = DEFAULT_INTERVAL;

  /// function to send gps status updates
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

  GpsStatus _lastStatus;
  Timer _timer;

  // ignore: close_sinks
  StreamController<GpsStatus> _statusController = StreamController.broadcast();

  /// function to return stream of gps status
  Stream<GpsStatus> get onStatusChange => _statusController.stream;

  /// function to check whether the gps status has listeners
  bool get hasListener => _statusController.hasListener;

}