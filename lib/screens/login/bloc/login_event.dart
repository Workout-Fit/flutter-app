part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

@immutable
class SendOtpEvent extends LoginEvent {
  final String phoneNumber;

  SendOtpEvent({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

@immutable
class VerifyOtpEvent extends LoginEvent {
  final String otp;

  VerifyOtpEvent({required this.otp});

  @override
  List<Object> get props => [otp];
}

class LogoutEvent extends LoginEvent {}

class OtpSentEvent extends LoginEvent {}

@immutable
class LoginCompleteEvent extends LoginEvent {
  final User user;

  LoginCompleteEvent(this.user);

  @override
  List<Object> get props => [user];
}

@immutable
class SignUpEvent extends LoginEvent {
  final String username;
  final String name;

  SignUpEvent(this.username, this.name);

  @override
  List<Object> get props => [username, name];
}

@immutable
class SignUpExceptionEvent extends LoginEvent {
  final String message;

  SignUpExceptionEvent(this.message);

  @override
  List<Object> get props => [message];
}

@immutable
class SignUpCompleteEvent extends LoginEvent {
  final User user;

  SignUpCompleteEvent(this.user);

  @override
  List<Object> get props => [user];
}

@immutable
class LoginExceptionEvent extends LoginEvent {
  final String message;

  LoginExceptionEvent(this.message);

  @override
  List<Object> get props => [message];
}
