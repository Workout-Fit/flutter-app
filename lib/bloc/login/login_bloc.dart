import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:meta/meta.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
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
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    print(event);
    if (event is SendOtpEvent) {
      yield LoadingState();
      subscription = sendOtp(event.phoneNumber).listen((event) {
        add(event);
      });
    } else if (event is OtpSendEvent) {
      yield OtpSentState();
    } else if (event is LoginCompleteEvent) {
      yield LoginCompleteState(event.user);
    } else if (event is LoginExceptionEvent) {
      yield ExceptionState(message: event.message);
    } else if (event is VerifyOtpEvent) {
      yield LoadingState();
      try {
        firebaseAuth.UserCredential result =
            await _authenticationRepository.verifyAndLogin(verID, event.otp);
        if (result.user != null) {
          yield (result.additionalUserInfo?.isNewUser ?? false)
              ? SignUpState(result.user!.toUser)
              : LoginCompleteState(result.user!.toUser);
        } else {
          yield OtpExceptionState(message: "Invalid otp!");
        }
      } catch (e) {
        yield OtpExceptionState(message: "Invalid otp!");
        print(e);
      }
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
    super.close();
  }

  Stream<LoginEvent> signUp() async* {
    // TODO: Create signUp login event
    // StreamController<LoginEvent> eventStream = StreamController();
  }

  Stream<LoginEvent> sendOtp(String phoneNumber) async* {
    StreamController<LoginEvent> eventStream = StreamController();
    final phoneVerificationCompleted =
        (firebaseAuth.AuthCredential authCredential) {
      eventStream
          .add(LoginCompleteEvent(_authenticationRepository.currentUser));
      eventStream.close();
    };
    final phoneVerificationFailed =
        (firebaseAuth.FirebaseAuthException authException) {
      print(authException.message);
      eventStream.add(LoginExceptionEvent(onError.toString()));
      eventStream.close();
    };
    final phoneCodeSent = (String verId, int? forceResent) {
      this.verID = verId;
      eventStream.add(OtpSendEvent());
      eventStream.close();
    };
    final phoneCodeAutoRetrievalTimeout = (String verID) {
      this.verID = verID;
      eventStream.close();
    };

    await _authenticationRepository.sendOtp(
      phoneNumber,
      Duration(seconds: 60),
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
