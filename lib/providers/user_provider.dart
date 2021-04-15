import 'package:envirocar/models/users.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User user;

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
}