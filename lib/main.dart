import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout/routes.dart';
import 'package:workout/screens/authenticate.dart';
import 'package:workout/screens/home.dart';
import 'package:workout/screens/scan_workout_qr.dart';
import 'package:workout/theme/theme.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = AppTheme();
    return Provider.value(
      value: appTheme,
      child: MaterialApp(
          initialRoute: '/login',
          title: 'Workout',
          theme: appTheme.lightTheme,
          onGenerateRoute: (settings) {
            late Widget page;
            if (settings.name == routeLogin)
              page = AuthenticationPage();
            else if (settings.name == routeQRScan)
              page = ScanWorkoutQR();
            else
              page = HomePage(routeName: settings.name ?? "");

            return MaterialPageRoute<dynamic>(
              builder: (context) => page,
              settings: settings,
            );
          }),
    );
  }
}
