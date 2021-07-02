import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:workout/screens/authenticate/login.dart';
import 'package:workout/screens/home/index.dart';
import 'package:workout/screens/scan_qr/index.dart';
import 'package:workout/screens/workout_master_detail/index.dart';
import 'package:workout/screens/workout_master_detail/workout_master_detail_arguments.dart';
import 'package:workout/theme/theme.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isPlatformDark =
        WidgetsBinding.instance!.window.platformBrightness == Brightness.dark;
    final theme = isPlatformDark ? darkTheme : lightTheme;

    return ThemeProvider(
      initTheme: theme,
      builder: (_, currentTheme) => MaterialApp(
          initialRoute: '/login',
          title: 'Workout',
          theme: currentTheme,
          onGenerateRoute: (settings) {
            late Widget page;
            switch (settings.name) {
              case LoginPage.routeName:
                page = LoginPage();
                break;
              case ScanQRPage.routeName:
                page = ScanQRPage();
                break;
              case WorkoutMasterDetailPage.routeName:
                final args = settings.arguments as WorkoutMasterDetailArguments;
                page = WorkoutMasterDetailPage(
                  readOnly: args.readOnly,
                  workoutId: args.workoutId,
                );
                break;
              default:
                page = HomePage(routeName: settings.name ?? "");
                break;
            }

            return MaterialPageRoute(
              builder: (context) => page,
              settings: settings,
            );
          }),
    );
  }
}
