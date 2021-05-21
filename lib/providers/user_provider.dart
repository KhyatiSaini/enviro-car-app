import 'package:envirocar/models/users.dart';
import 'package:envirocar/providers/authentication_status_provider.dart';
import 'package:envirocar/screens/home_screen.dart';
import 'package:envirocar/utilities/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  User user;
  bool isSignedIn;
  String username;

  UserProvider() {
    isSignedIn = false;
    updateAuthenticationStatus();
  }

  /// function to update authentication status upon listening stream updates
  void updateAuthenticationStatus() {
    AuthenticationStatusProvider().onStatusChange.listen((username) {
      if (username.isNotEmpty && username != '')
        isSignedIn = true;
      else
        isSignedIn = false;
      notifyListeners();
    });
  }

  /// function to assign data to [User]
  Future assignUser(
      String name,
      String mail,
      String created,
      String modified,
      String acceptedTermsOfUseVersion,
      String acceptedPrivacyStatementVersion) async {
    this.user = User(
        name: name,
        mail: mail,
        created: created,
        modified: modified,
        acceptedTermsOfUseVersion: acceptedTermsOfUseVersion,
        acceptedPrivacyStatementVersion: acceptedPrivacyStatementVersion
    );
  }

  /// function to sign-in the user and update the authentication status
  Future signIn(String username, String password, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('X-User', username);
    sharedPreferences.setString('X-token', password);

    AuthenticationStatusProvider().authenticationStatus();
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }

  /// function to logout and update the authentication status
  Future logout(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String username = sharedPreferences.getString('X-User');
    sharedPreferences.remove('X-User');
    sharedPreferences.remove('X-token');
    showSnackBar(context, 'Goodbye $username');
    AuthenticationStatusProvider().authenticationStatus();
  }

  /// function to get [username]
  Future<String> get getUserName async {
    if (userLoggedIn) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      username = sharedPreferences.getString('X-User');
    }
    return username;
  }

  /// function to check whether user is logged in
  bool get userLoggedIn => isSignedIn;
}