import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:workout/repos/authentication_repository.dart';
import 'package:workout/utils/hive_init.dart';

import 'app/app.dart';
import 'models/User.dart';

void main() async {
  await initHiveForFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox(appBox);
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  final authenticationRepository = AuthenticationRepository();
  runApp(App(authenticationRepository: authenticationRepository));
}
