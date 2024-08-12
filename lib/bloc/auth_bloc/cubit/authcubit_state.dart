import 'package:flutter/material.dart';

abstract class AuthState {}


class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthUserNewState extends AuthState {}

class AuthUserLoggedInState extends AuthState {
  final String userId;

  AuthUserLoggedInState({
    required this.userId,
  });
}



class AuthCodeSentState extends AuthState {}

class AuthLoggedOutState extends AuthState {}


class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState(this.error);
}

class AuthVerifyErrorState extends AuthState {
  final String error;

  AuthVerifyErrorState(this.error);
}

class AuthCheckExists extends AuthState {
  final String userId;

  AuthCheckExists({
    required this.userId,
  });
}

class AuthCheckNewState extends AuthState {}
