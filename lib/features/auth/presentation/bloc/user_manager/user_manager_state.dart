part of 'user_manager_bloc.dart';

abstract class UserManagerState extends Equatable {
  const UserManagerState();
  
  @override
  List<Object> get props => [];
}

class UserManagerInitial extends UserManagerState {}

class RegisteringUserState extends UserManagerState {}

class RegisteredUserState extends UserManagerState {}

class RegisterUserErrorState extends UserManagerState {
  final String message;
  RegisterUserErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

//TODO: update user States
