import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:graphql/client.dart';
import 'package:workout/api/schema.dart';
import 'package:workout/models/User.dart';
import 'package:workout/utils/graphql_client.dart';

class SignUpFailure implements Exception {}

class LogInWithEmailAndPasswordFailure implements Exception {}

class LogInWithPhoneNumberFailure implements Exception {}

class LogOutFailure implements Exception {}

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  ProfileInfoMixin$ProfileInfo? _profileInfo;

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

  Future<firebase_auth.UserCredential> verifyAndLogin(
    String verificationId,
    String smsCode,
  ) async {
    try {
      final authCredential = firebase_auth.PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final userCredential =
          await _firebaseAuth.signInWithCredential(authCredential);
      getProfileInfo(userCredential.user?.uid ?? '');
      return userCredential;
    } on Exception {
      throw LogInWithPhoneNumberFailure();
    }
  }

  get profileInfo => _profileInfo;

  Future<QueryResult> signUp(
    String userId,
    ProfileInfoInput profileInfo,
  ) async {
    return client.mutate(
      MutationOptions(
        document: CREATE_USER_MUTATION_DOCUMENT,
        variables: CreateUserArguments(
          id: userId,
          profileInfo: profileInfo,
        ).toJson(),
      ),
    );
  }

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      return user;
    });
  }

  Future<ProfileInfoMixin$ProfileInfo?> getProfileInfo(
    String userId,
  ) async {
    final result = await client.query(
      QueryOptions(
        document: GET_USER_BY_ID_QUERY_DOCUMENT,
        variables: GetUserByIdArguments(id: userId).toJson(),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );

    _profileInfo = result.data!["getUserById"] != null
        ? ProfileInfoMixin$ProfileInfo.fromJson(
            result.data!["getUserById"]["profileInfo"],
          )
        : null;
    return _profileInfo;
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
