import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout/repos/authentication_repository.dart';
import 'package:workout/screens/authenticate/login.dart';

import 'package:workout/theme/theme.dart';
import 'package:workout/utils/hive_init.dart';

import 'screens/app.dart';
import 'bloc/authentication/authentication_bloc.dart';

void main() async {
  await initHiveForFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  runApp(Main(authenticationRepository: authenticationRepository));
}

class Main extends StatelessWidget {
  final authenticationRepository;

  const Main({
    Key? key,
    required this.authenticationRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPlatformDark =
        WidgetsBinding.instance!.window.platformBrightness == Brightness.dark;
    final theme = isPlatformDark ? darkTheme : lightTheme;

    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        child: ThemeProvider(
          initTheme: theme,
          builder: (context, currentTheme) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                return MaterialApp(
                  title: 'Workout',
                  theme: currentTheme,
                  home: (() {
                    switch (state.status) {
                      case AuthenticationStatus.unauthenticated:
                        return LoginPage(
                          authenticationRepository: authenticationRepository,
                        );
                      case AuthenticationStatus.authenticated:
                        return App();
                    }
                  }()),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
