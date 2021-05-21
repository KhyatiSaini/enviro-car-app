import 'package:envirocar/services/gps_status_checker.dart';
import 'package:flutter/foundation.dart';

class GpsStatusProvider extends ChangeNotifier {

  GpsStatus gpsStatus;

  GpsStatusProvider() {
    gpsStatus = GpsStatus.disabled;
    updateGpsStatus();
  }

  /// function to update gps stream updates upon listening status updates
  void updateGpsStatus() {
    GpsStatusChecker().onStatusChange.listen((status) {
      gpsStatus = status;
      notifyListeners();
    });
  }

  /// function to get current [gpsState]
  GpsStatus get gpsState => gpsStatus;

}