import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout/repos/authentication_repository.dart';
import 'package:workout/utils/hive_init.dart';

import 'app/app.dart';

void main() async {
  await initHiveForFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository
      .getProfileInfo(authenticationRepository.currentUser.id);
  runApp(App(authenticationRepository: authenticationRepository));
}
