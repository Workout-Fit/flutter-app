import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:workout/models/User.dart';

class SignUpFailure implements Exception {}

class LogInWithEmailAndPasswordFailure implements Exception {}

class LogInWithPhoneNumberFailure implements Exception {}

class LogOutFailure implements Exception {}

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;


  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  Future<void> sendOtp(
      String phoneNumber,
      Duration timeOut,
      firebase_auth.PhoneVerificationFailed phoneVerificationFailed,
      firebase_auth.PhoneVerificationCompleted phoneVerificationCompleted,
      firebase_auth.PhoneCodeSent phoneCodeSent,
      firebase_auth.PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeOut,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout,
      );
    } on Exception {
      throw LogInWithPhoneNumberFailure();
    }
  }

  Future<firebase_auth.UserCredential> verifyAndLogin(
    String verificationId,
    String smsCode,
  ) {
    try {
      firebase_auth.AuthCredential authCredential =
          firebase_auth.PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);
      return _firebaseAuth.signInWithCredential(authCredential);
    } on Exception {
      throw LogInWithPhoneNumberFailure();
    }
  }

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      return user;
    });
  }

  Future<void> signUp() async {
    // TODO: Add createUser mutation.
  }

  Future<void> logOut() async {
    try {
      return _firebaseAuth.signOut();
    } on Exception {
      throw LogOutFailure();
    }
  }

  User get currentUser => _firebaseAuth.currentUser?.toUser ?? User.empty;
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, phoneNumber: phoneNumber);
  }
}
