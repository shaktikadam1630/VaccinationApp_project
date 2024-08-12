// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vaccination/model/user_model.dart';


class ActiveUser {
  static Users currentuser = Users(
    loginValue: null,
    profilePics: null,
    parentemail:null,
    userId: null,
    fullname: null,
    motherAadharNo:null,
    childAadharNo:null,
    birthdate:null,

  );

  static Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .where('userId', isEqualTo: userId)
              .limit(1) // Limit to 1 document as userId should be unique
              .get();

      if (snapshot.docs.isNotEmpty) {
        Map<String, dynamic> user = snapshot.docs.first.data();
        ActiveUser.currentuser = Users.fromMap(user);
        print('Current User Data:');
        print(
            'Login Value: ${ActiveUser.currentuser.loginValue ?? 'Not provided'}');
        // print('Name: ${ActiveUser.currentuser.name ?? 'Not provided'}');
        // print('User ID: ${ActiveUser.currentuser.userId ?? 'Not provided'}');
        // print('Gender: ${ActiveUser.currentuser.gender ?? 'Not provided'}');
        // print('City: ${ActiveUser.currentuser.city ?? 'Not provided'}');
        // print('Birthday: ${ActiveUser.currentuser.birthday ?? 'Not provided'}');
        // print(
        //     'Description: ${ActiveUser.currentuser.description ?? 'Not provided'}');
        // print(
        //     'Interests: ${ActiveUser.currentuser.interests?.join(', ') ?? 'Not provided'}');

        return user;
      } else {
        print('User with userId $userId does not exist ');
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }
}
