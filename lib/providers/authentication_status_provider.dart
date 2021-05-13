import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationStatusProvider {

  factory AuthenticationStatusProvider() => _authenticationStatusProvider;
  AuthenticationStatusProvider._() {
    _controller.onListen = () {
      authenticationStatus();
    };
  }

  static final AuthenticationStatusProvider _authenticationStatusProvider = AuthenticationStatusProvider._();

  authenticationStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String username = sharedPreferences.getString('X-User') ?? '';
    // print('user $username');
    _controller.add(username);
  }

  // ignore: close_sinks
  StreamController<String> _controller = StreamController.broadcast();

  Stream<String> get onStatusChange => _controller.stream;

  bool get hasListeners => _controller.hasListener;

}