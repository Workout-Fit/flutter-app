part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
}

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    required this.status,
    this.user = User.empty,
    this.profileInfo,
  });

  const AuthenticationState.authenticated(User user,
      [ProfileInfoMixin$ProfileInfo? profileInfo])
      : this._(
          status: AuthenticationStatus.authenticated,
          user: user,
          profileInfo: profileInfo,
        );

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final User user;
  final ProfileInfoMixin$ProfileInfo? profileInfo;
  final AuthenticationStatus status;

  @override
  List<Object> get props => [status, user];
}
