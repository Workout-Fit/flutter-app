part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {}

class InitialLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class OtpSentState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class OtpVerifiedState extends LoginState {
  @override
  List<Object> get props => [];
}

@immutable
class LoginCompleteState extends LoginState {
  final User user;
  final ProfileInfoMixin$ProfileInfo? profileInfo;

  LoginCompleteState(this.user, this.profileInfo);

  @override
  List<Object> get props => [user, profileInfo ?? {}];
}

@immutable
class SignUpLoadingState extends LoginState {
  final User user;

  SignUpLoadingState(this.user);

  @override
  List<Object> get props => [user];
}

class SignUpExceptionState extends LoginState {
  final String message;

  SignUpExceptionState({required this.message});

  @override
  List<Object> get props => [message];
}

class ExceptionState extends LoginState {
  final String message;

  ExceptionState({required this.message});

  @override
  List<Object> get props => [message];
}

class OtpExceptionState extends LoginState {
  final String message;

  OtpExceptionState({required this.message});

  @override
  List<Object> get props => [message];
}
