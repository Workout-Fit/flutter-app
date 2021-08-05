import 'dart:async';

import 'package:workout/repos/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:workout/models/User.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AuthenticationState.authenticated(
                  authenticationRepository.currentUser)
              : const AuthenticationState.unauthenticated(),
        ) {
    _userSubscription = _authenticationRepository.user.listen(_onUserChanged);
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(User user) => add(AuthenticationUserChanged(user));

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationUserChanged) {
      yield _mapUserChangedToState(event, state);
    } else if (event is AuthenticationLogoutRequested) {
      yield AuthenticationState.unauthenticated();
      _authenticationRepository.logOut();
    }
  }

  AuthenticationState _mapUserChangedToState(
    AuthenticationUserChanged event,
    AuthenticationState state,
  ) {
    return event.user.isNotEmpty
        ? AuthenticationState.authenticated(event.user)
        : const AuthenticationState.unauthenticated();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
