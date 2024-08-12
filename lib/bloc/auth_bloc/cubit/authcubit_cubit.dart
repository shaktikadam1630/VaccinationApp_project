import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vaccination/bloc/auth_bloc/cubit/authcubit_state.dart';
import 'package:vaccination/services/auth_service.dart';
import 'package:vaccination/services/getuser.dart';



class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthCubit() : super(AuthInitialState()) {
    Future.delayed(Duration.zero, () {
      // checkUserStatus();
    });
  }

  //checking user has already signed in or not;
  void checkUserStatus() async {
    emit(AuthLoadingState());
    User? user = FirebaseAuth.instance.currentUser;
    String userId;

    if (user != null) {
      print(user.toString());
      print('check user in phone');
      
      userId = await AuthService().fetchUserByPhoneNumber(user.phoneNumber!);
      print(userId);
      if (userId != "null") {
        emit(AuthCheckExists(userId: userId));
      } else {
        emit(AuthCheckNewState());
      }
    } else {
      emit(AuthCheckNewState());
    }
  }

  //login with phone logic
  String? _verificationId;

  void sendOTP(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        emit(AuthCodeSentState());
      },
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {
        emit(AuthErrorState(error.toString()));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void verifyOTP(String otp, String phone) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: otp);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        String userId = await AuthService().fetchUserByPhoneNumber(phone);

        if (userId != "null") {
          print("In verify otp $userId");
          emit(AuthUserLoggedInState(
            userId: userId,
          ));
        } else {
          ActiveUser.currentuser.loginValue = phone;
          print("In verify otp new user ");
          emit(AuthUserNewState());
        }
      }
    } catch (e) {
      emit(AuthVerifyErrorState('Error verifying OTP: $e'));
    }
  }

//Log out logic
  void logOut() async {
    await _auth.signOut();
    emit(AuthLoggedOutState());
  }
}
