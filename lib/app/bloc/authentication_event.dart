part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

class AuthenticationUserChanged extends AuthenticationEvent {
  const AuthenticationUserChanged(this.user, [this.profileInfo]);

  final User user;
  final ProfileInfoMixin$ProfileInfo? profileInfo;

  @override
  List<Object> get props => [user, profileInfo ?? {}];
}

class AuthenticationUserInfo extends AuthenticationEvent {
  const AuthenticationUserInfo(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}