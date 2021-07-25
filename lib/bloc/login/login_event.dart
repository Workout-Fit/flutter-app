part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

@immutable
class SendOtpEvent extends LoginEvent {
  final String phoneNumber;

  SendOtpEvent({required this.phoneNumber});
}

@immutable
class VerifyOtpEvent extends LoginEvent {
  final String otp;

  VerifyOtpEvent({required this.otp});
}

class LogoutEvent extends LoginEvent {}

class OtpSendEvent extends LoginEvent {}

class LoginCompleteEvent extends LoginEvent {
  final User user;

  LoginCompleteEvent(this.user);
}

class SignUpEvent extends LoginEvent {
  final User user;

  SignUpEvent(this.user);
}

@immutable
class LoginExceptionEvent extends LoginEvent {
  final String message;

  LoginExceptionEvent(this.message);
}