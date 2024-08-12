import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String? loginValue;
  List<String>? profilePics;
  String? userId;
  String? fullname;
  String? parentemail;
  String? motherAadharNo;
  String? childAadharNo;
  DateTime? birthdate;


  Users({
    this.loginValue,
    this.profilePics,
    this.userId, 
    this.fullname,
    this.motherAadharNo,
    this.childAadharNo,
    this.birthdate,
    this.parentemail,
  });

  // Convert a Firestore document (Map) to a Users object
  factory Users.fromMap(Map<String, dynamic> user) {
    return Users(
      loginValue: user['loginValue'],
      profilePics: user['profilePics'] != null
          ? List<String>.from(user['profilePics'])
          : null,
      userId: user['userId'],
      fullname: user['fullname'],
      motherAadharNo: user['motherAadharNo'],
      childAadharNo: user['childAadharNo'],
     birthdate: user['birthdate'] is Timestamp 
          ? (user['birthdate'] as Timestamp).toDate()
          : user['birthdate'] as DateTime?,
      parentemail: user['parentemail'],
    );
  }

  // Convert a Users object to a Firestore document (Map)
  static Map<String, dynamic> toMap(Users user) {
    return <String, dynamic>{
      'loginValue': user.loginValue,
      'profilePics': user.profilePics,
      'userId': user.userId,
      'fullname': user.fullname,
      'motherAadharNo': user.motherAadharNo,
      'childAadharNo': user.childAadharNo,
      'birthdate': user.birthdate,
      'parentemail': user.parentemail,
    };
  }
}
