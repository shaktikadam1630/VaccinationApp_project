import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vaccination/bloc/Userbloc/userbloc_event.dart';
import 'package:vaccination/model/user_model.dart';
import 'package:vaccination/services/getuser.dart';

part 'userbloc_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserInformationSaveEvent>(userInformationSaveEvent);
  }

  Future<void> userInformationSaveEvent(
      UserInformationSaveEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());

    try {
      String loginValue = event.loginValue.trim();
      String fullname = event.fullname.trim();
      String userId = event.userId.trim();
      String motherAadharNo = event.motherAadharNo.trim();
      String childAadharNo = event.childAadharNo.trim();
      DateTime? birthdate = event.birthdate;
      String parentemail = event.parentemail.trim();

      if (loginValue.isEmpty ||
          fullname.isEmpty ||
          userId.isEmpty ||
          motherAadharNo.isEmpty ||
          childAadharNo.isEmpty ||
          parentemail.isEmpty ||
          birthdate == null) {
        emit(UserEmptyState());
        return;
      }

      // Validate userId
      if (!isValidUserId(userId)) {
        emit(UserInvalidIDState());
        return;
      }

      // Check if the user ID already exists
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("userId", isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        emit(UserExistsState());
        return;
      }

      // Upload profile pictures to Firebase Storage
      List<String> profilePicUrls = [];
      for (String path in event.profilePics) {
        File file = File(path);
        String fileName = 'profile_pics/$userId/${file.uri.pathSegments.last}';
        UploadTask uploadTask =
            FirebaseStorage.instance.ref(fileName).putFile(file);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        profilePicUrls.add(downloadUrl);
      }

      // Save user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'loginValue': loginValue,
        'fullname': fullname,
        'userId': userId,
        'motherAadharNo': motherAadharNo,
        'profilePics': profilePicUrls,
        'childAadharNo': childAadharNo,
        'birthdate': birthdate,
        'parentemail': parentemail,
      });

      ActiveUser.currentuser = Users(
        loginValue: loginValue,
        profilePics: profilePicUrls,
        userId: userId,
        fullname: fullname,
        motherAadharNo: motherAadharNo,
        childAadharNo: childAadharNo,
        birthdate: birthdate,
        parentemail: parentemail,
      );

      emit(UserLoginSuccessState());
    } catch (e) {
      emit(UserErrorState('Error saving user information: $e'));
    }
  }

  bool isValidUserId(String userId) {
    // Regular expression to match a valid user ID
    // Assuming a valid user ID is alphanumeric and may contain underscores
    RegExp regex = RegExp(r'^[a-zA-Z0-9_]+$');
    return regex.hasMatch(userId);
  }
}
