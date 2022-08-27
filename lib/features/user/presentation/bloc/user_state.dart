part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class SignInLoadingState extends UserState {}

class SignInErrorState extends UserState {
  final String msg;
  SignInErrorState(this.msg);
  @override
  List<Object> get props => [msg];
}

class SignInSuccessState extends UserState {}
