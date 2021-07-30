import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:workout/repos/authentication_repository.dart';
import 'package:workout/utils/hive_init.dart';

import 'app/app.dart';

void main() async {
  await initHiveForFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: kDebugMode ? ".env.development" : ".env");
  await Firebase.initializeApp();
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository
      .getProfileInfo(authenticationRepository.currentUser.id);
  runApp(App(authenticationRepository: authenticationRepository));
}
