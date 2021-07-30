import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:meta/meta.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:workout/api/schema.dart';
import 'package:workout/models/User.dart';
import 'package:workout/repos/authentication_repository.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;
  StreamSubscription? subscription;

  String verID = "";

  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(InitialLoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SendOtpEvent) {
      yield LoadingState();
      subscription = sendOtp(event.phoneNumber).listen((event) {
        add(event);
      });
    } else if (event is OtpSentEvent) {
      yield OtpSentState();
    } else if (event is LoginExceptionEvent) {
      yield ExceptionState(message: event.message);
    } else if (event is VerifyOtpEvent) {
      yield LoadingState();
      try {
        firebaseAuth.UserCredential result =
            await _authenticationRepository.verifyAndLogin(verID, event.otp);
        if (result.user != null) {
          yield LoginCompleteState(
            result.user!.toUser,
            _authenticationRepository.profileInfo,
          );
        } else {
          yield OtpExceptionState(message: "Invalid otp!");
        }
      } catch (e) {
        yield OtpExceptionState(message: "Invalid otp!");
        print(e);
      }
    } else if (event is SignUpEvent) {
      yield SignUpLoadingState(_authenticationRepository.currentUser);
      subscription = signUp(
        username: event.username,
        name: event.name,
      ).listen((event) {
        add(event);
      });
    } else if (event is SignUpCompleteEvent) {
      ProfileInfoMixin$ProfileInfo? profileInfo =
          await _authenticationRepository.getProfileInfo(event.user.id);
      yield LoginCompleteState(event.user, profileInfo);
    } else if (event is SignUpExceptionEvent) {
      yield InitialLoginState();
    } else if (event is LogoutEvent) {
      await _authenticationRepository.logOut();
    }
  }

  @override
  void onEvent(LoginEvent event) {
    super.onEvent(event);
    print(event);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print(stacktrace);
  }

  Future<void> close() async {
    print("Bloc closed");
    subscription?.cancel();
    super.close();
  }

  Stream<LoginEvent> signUp({
    required String username,
    required String name,
    String? bio,
    double? height,
    double? weight,
  }) async* {
    StreamController<LoginEvent> eventStream = StreamController();
    try {
      final result = await _authenticationRepository.signUp(
        _authenticationRepository.currentUser.id,
        ProfileInfoInput(
          username: username,
          name: name,
          bio: bio,
          height: height,
          weight: weight,
        ),
      );
      eventStream.add(
        SignUpCompleteEvent(
          _authenticationRepository.currentUser,
          ProfileInfoMixin$ProfileInfo.fromJson(
            result.data!["createUser"]["profileInfo"],
          ),
        ),
      );
      eventStream.close();
    } catch (e) {
      eventStream.add(
        SignUpExceptionEvent('Error when signing up'),
      );
      eventStream.close();
      throw e;
    }

    yield* eventStream.stream;
  }

  Stream<LoginEvent> sendOtp(String phoneNumber) async* {
    StreamController<LoginEvent> eventStream = StreamController();
    final phoneVerificationCompleted =
        (firebaseAuth.AuthCredential authCredential) {};
    final phoneVerificationFailed =
        (firebaseAuth.FirebaseAuthException authException) {
      print(authException.message);
      eventStream.add(LoginExceptionEvent(onError.toString()));
      eventStream.close();
    };
    final phoneCodeSent = (String verId, int? forceResent) {
      this.verID = verId;
      eventStream.add(OtpSentEvent());
      eventStream.close();
    };
    final phoneCodeAutoRetrievalTimeout = (String verID) {
      this.verID = verID;
      eventStream.close();
    };

    await _authenticationRepository.sendOtp(
      phoneNumber,
      Duration(seconds: 1),
      phoneVerificationFailed,
      phoneVerificationCompleted,
      phoneCodeSent,
      phoneCodeAutoRetrievalTimeout,
    );

    yield* eventStream.stream;
  }
}

extension on firebaseAuth.User {
  User get toUser {
    return User(id: uid, email: email, phoneNumber: phoneNumber);
  }
}
