import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:workout/app/bloc/authentication_bloc.dart';
import 'package:workout/repos/authentication_repository.dart';
import 'package:workout/screens/home/home.dart';
import 'package:workout/screens/login/login.dart';
import 'package:workout/screens/scan_qr/scan_qr.dart';
import 'package:workout/screens/workout/workout.dart';
import 'package:workout/theme/theme.dart';

const appBox = 'workout';
const darkModeKey = 'darkMode';

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  App({Key? key, required this.authenticationRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        child: ThemeProvider(
          initTheme: Hive.box('workout').get(darkModeKey, defaultValue: false)
              ? darkTheme
              : lightTheme,
          builder: (context, currentTheme) {
            return BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (BuildContext context, AuthenticationState state) {
                if (state.user.isNotEmpty && state.user.isSignedUp) {
                  _navigatorKey.currentState!.pushNamedAndRemoveUntil(
                      HomePage.routeName, (route) => false);
                } else if (state.user.isNotEmpty && !state.user.isSignedUp) {
                  _navigatorKey.currentState!.pushNamedAndRemoveUntil(
                      SignUpPage.routeName, (route) => false);
                } else
                  _navigatorKey.currentState!.pushNamedAndRemoveUntil(
                      LoginPage.routeName, (route) => false);
              },
              builder: (BuildContext context, AuthenticationState state) {
                return MaterialApp(
                  title: 'Workout',
                  navigatorKey: _navigatorKey,
                  theme: currentTheme,
                  initialRoute: _getInitialRoute(state),
                  onGenerateRoute: (settings) => _generateRoutes(settings),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String _getInitialRoute(AuthenticationState state) {
    if (state.status == AuthenticationStatus.authenticated) {
      return state.user.isSignedUp ? HomePage.routeName : SignUpPage.routeName;
    } else
      return LoginPage.routeName;
  }

  MaterialPageRoute _generateRoutes(RouteSettings settings) {
    Widget page = Container();
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
        page = SignUpPage();
      else if (settings.name!.startsWith(LoginPage.routeName)) {
        page = LoginPage(subRouteName: settings.name ?? "");
      } else if (settings.name!.startsWith(HomePage.routeName))
        page = HomePage(subRouteName: settings.name ?? "");
    }
    return MaterialPageRoute(
      builder: (BuildContext context) => page,
      settings: settings,
    );
  }
}
