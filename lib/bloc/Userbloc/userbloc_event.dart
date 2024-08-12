import 'package:flutter/material.dart';

abstract class UserEvent {
  const UserEvent();
}

class UserInformationSaveEvent extends UserEvent {
  final String loginValue;
  final String fullname;
  final String userId;
  final String parentemail;
  final String motherAadharNo;
  final String childAadharNo;
   final DateTime? birthdate;
  final List<String> profilePics;

  UserInformationSaveEvent({
    required this.loginValue,
    required this.fullname,
    required this.userId,
    required this.parentemail,
    required this.motherAadharNo,
    required this.childAadharNo,
    required this.birthdate,
    required this.profilePics,
  });
}
