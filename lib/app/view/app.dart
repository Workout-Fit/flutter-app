import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout/app/bloc/authentication_bloc.dart';
import 'package:workout/screens/home/home.dart';
import 'package:workout/screens/login/login.dart';
import 'package:workout/screens/login/view/phone_form.dart';
import 'package:workout/screens/scan_qr/scan_qr.dart';
import 'package:workout/screens/workout/workout.dart';
import 'package:workout/theme/theme.dart';

class App extends StatelessWidget {
  final authenticationRepository;

  App({
    Key? key,
    required this.authenticationRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPlatformDark =
        WidgetsBinding.instance!.window.platformBrightness == Brightness.dark;
    final theme = isPlatformDark ? darkTheme : lightTheme;

    return BlocProvider(
      create: (context) => AuthenticationBloc(
        authenticationRepository: authenticationRepository,
      ),
      child: ThemeProvider(
        initTheme: theme,
        builder: (context, currentTheme) {
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (_, AuthenticationState state) {
              return MaterialApp(
                title: 'Workout',
                theme: currentTheme,
                initialRoute: _getInitialRoute(state),
                onGenerateRoute: (settings) => _generateRoutes(settings),
              );
            },
          );
        },
      ),
    );
  }

  String _getInitialRoute(AuthenticationState state) {
    if (state.status == AuthenticationStatus.authenticated) {
      return state.profileInfo == null
          ? SignUpPage.routeName
          : HomePage.routeName;
    } else
      return PhoneForm.routeName;
  }

  MaterialPageRoute _generateRoutes(RouteSettings settings) {
    late Widget page;
    final workoutId = new RegExp(r"^/view/([^\s]+)$")
        .firstMatch(settings.name ?? '')
        ?.group(1);
    if (workoutId != null) {
      page = WorkoutPage(workoutId: workoutId);
    } else {
      if (settings.name == ScanQRPage.routeName)
        page = ScanQRPage();
      else if (settings.name == WorkoutPage.routeName) {
        final args = settings.arguments as WorkoutArguments;
        page = WorkoutPage(workoutId: args.workoutId);
      } else if (settings.name == NewWorkoutPage.routeName)
        page = NewWorkoutPage();
      else if (settings.name == SignUpPage.routeName)
        page = SignUpPage(authenticationRepository: authenticationRepository);
      else if (settings.name!.startsWith(LoginPage.routeName)) {
        page = LoginPage(
          authenticationRepository: authenticationRepository,
          subRouteName: settings.name ?? "",
        );
      } else
        page = HomePage(subRouteName: settings.name ?? "");
    }
    return MaterialPageRoute(
      builder: (context) => page,
      settings: settings,
    );
  }
}
