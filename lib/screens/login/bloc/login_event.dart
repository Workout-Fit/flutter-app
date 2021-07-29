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

class LoginCompleteEvent extends LoginEvent {
  final User user;

  LoginCompleteEvent(this.user);
}

class SignUpEvent extends LoginEvent {
  final String username;
  final String name;

  SignUpEvent(this.username, this.name);
}

class SignUpExceptionEvent extends LoginEvent {
  final String message;

  SignUpExceptionEvent(this.message);
}

@immutable
class SignUpCompleteEvent extends LoginEvent {
  final User user;
  final ProfileInfoMixin$ProfileInfo profileInfo;

  SignUpCompleteEvent(this.user, this.profileInfo);
}

@immutable
class LoginExceptionEvent extends LoginEvent {
  final String message;

  LoginExceptionEvent(this.message);
}
