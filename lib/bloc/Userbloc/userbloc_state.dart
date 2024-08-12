part of 'userbloc_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserExistsState extends UserState {}

class UserInvalidIDState extends UserState {}

class UserSavedState extends UserState {}

class UserEmptyState extends UserState {}

class UserLoginSuccessState extends UserState {}



class UserErrorState extends UserState {
  UserErrorState(String s);
}

class SaveAlluserDataState extends UserState {}

class UserAllLoadingState extends UserState {}
