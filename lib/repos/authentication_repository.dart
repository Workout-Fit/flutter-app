import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:graphql/client.dart';
import 'package:hive/hive.dart';
import 'package:workout/api/schema.dart';
import 'package:workout/models/User.dart';
import 'package:workout/utils/graphql_client.dart';

class SignUpFailure implements Exception {}

class LogInWithEmailAndPasswordFailure implements Exception {}

class LogInWithPhoneNumberFailure implements Exception {}

class LogOutFailure implements Exception {}

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final _userBox = Hive.box('workout');

  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  Future<void> sendOtp(
    String phoneNumber,
    Duration timeOut,
    firebase_auth.PhoneVerificationFailed phoneVerificationFailed,
    firebase_auth.PhoneVerificationCompleted phoneVerificationCompleted,
    firebase_auth.PhoneCodeSent phoneCodeSent,
    firebase_auth.PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout,
  ) async {
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

  Future<User> verifyAndLogin(String verificationId, String smsCode) async {
    try {
      final authCredential = firebase_auth.PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final userCredential =
          await _firebaseAuth.signInWithCredential(authCredential);
      return userCredential.user != null
          ? userCredential.user!.toUser(
              await this.isCurrentUserSignedUp(userCredential.user!.uid),
            )
          : User.empty;
    } on Exception {
      throw LogInWithPhoneNumberFailure();
    }
  }

  Future<User> signUp(
    String userId,
    ProfileInfoInput profileInfo,
  ) async {
    final result = await client.mutate(
      MutationOptions(
        document: CREATE_USER_MUTATION_DOCUMENT,
        variables: CreateUserArguments(
          id: userId,
          profileInfo: profileInfo,
        ).toJson(),
      ),
    );

    currentUser = currentUser.copyWith(isSignedUp: result.data!.isNotEmpty);

    return currentUser;
  }

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser != null) {
        final isSignedUp = await this.isCurrentUserSignedUp(firebaseUser.uid);
        final user = firebaseUser.toUser(isSignedUp);
        _userBox.put(User.boxKeyName, user);
        return user;
      } else {
        _userBox.put(User.boxKeyName, User.empty);
        return User.empty;
      }
    });
  }

  Future<bool> isCurrentUserSignedUp(
    String userId,
  ) async {
    final result = await client.query(
      QueryOptions(
        document: GET_USER_BY_ID_QUERY_DOCUMENT,
        variables: GetUserByIdArguments(id: userId).toJson(),
      ),
    );

    return result.data != null;
  }

  Future<void> logOut() async {
    try {
      return _firebaseAuth.signOut();
    } on Exception {
      throw LogOutFailure();
    }
  }

  User get currentUser => _userBox.get(User.boxKeyName) ?? User.empty;

  set currentUser(User user) {
    _userBox.put(User.boxKeyName, user);
  }
}

extension on firebase_auth.User {
  User toUser(bool isSignedUp) {
    return User(
      id: uid,
      email: email,
      phoneNumber: phoneNumber,
      isSignedUp: isSignedUp,
    );
  }
}
