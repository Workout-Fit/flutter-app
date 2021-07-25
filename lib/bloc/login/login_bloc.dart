import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:workout/repos/authentication_repository.dart';
import 'package:flutter/material.dart';

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
  LoginCompleteState(this.user);

  @override
  List<Object> get props => [user];
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

class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

@immutable
class SendOtpEvent extends LoginEvent {
  final String phoneNumber;

  SendOtpEvent({required this.phoneNumber});
}

class AppStartEvent extends LoginEvent {}

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

@immutable
class LoginExceptionEvent extends LoginEvent {
  final String message;

  LoginExceptionEvent(this.message);
}

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
        UserCredential result =
            await _authenticationRepository.verifyAndLogin(verID, event.otp);
        if (result.user != null) {
          yield LoginCompleteState(result.user!);
        } else {
          yield OtpExceptionState(message: "Invalid otp!");
        }
      } catch (e) {
        yield OtpExceptionState(message: "Invalid otp!");
        print(e);
      }
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

  Stream<LoginEvent> sendOtp(String phoneNumber) async* {
    StreamController<LoginEvent> eventStream = StreamController();
    final phoneVerificationCompleted = (AuthCredential authCredential) {
      _authenticationRepository.currentUser;
      _authenticationRepository.currentUser.catchError((onError) {
        print(onError);
      }).then((user) {
        eventStream.add(LoginCompleteEvent(user));
        eventStream.close();
      });
    };
    final phoneVerificationFailed = (FirebaseAuthException authException) {
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
