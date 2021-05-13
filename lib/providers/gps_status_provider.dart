import 'package:envirocar/services/gps_status_checker.dart';
import 'package:flutter/foundation.dart';

class GpsStatusProvider extends ChangeNotifier {

  GpsStatus gpsStatus;

  GpsStatusProvider() {
    gpsStatus = GpsStatus.disabled;
    updateGpsStatus();
  }

  void updateGpsStatus() {
    GpsStatusChecker().onStatusChange.listen((status) {
      gpsStatus = status;
      notifyListeners();
    });
  }

  GpsStatus get gpsState => gpsStatus;

}