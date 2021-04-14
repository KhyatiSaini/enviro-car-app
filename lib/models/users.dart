import 'package:flutter/material.dart';

class User {
  String name;
  String mail;
  String created;
  String modified;
  String acceptedTermsOfUseVersion;
  String acceptedPrivacyStatementVersion;

  User({
    @required this.name,
    @required this.mail,
    @required this.created,
    @required this.modified,
    @required this.acceptedTermsOfUseVersion,
    @required this.acceptedPrivacyStatementVersion
  });
}