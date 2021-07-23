import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workout/screens/home/index.dart';
import 'package:workout/screens/scan_qr/index.dart';
import 'package:workout/screens/workout/new_workout.dart';
import 'package:workout/screens/workout/workout.dart';
import 'package:workout/screens/workout/workout_arguments.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        late Widget page;
        final workoutId = new RegExp(r"^/view/([^\s]+)$")
            .firstMatch(settings.name ?? '')
            ?.group(1);
        if (workoutId != null) {
          page = WorkoutPage(workoutId: workoutId);
        } else {
          switch (settings.name) {
            case ScanQRPage.routeName:
              page = ScanQRPage();
              break;
            case WorkoutPage.routeName:
              final args = settings.arguments as WorkoutArguments;
              page = WorkoutPage(workoutId: args.workoutId);
              break;
            case NewWorkoutPage.routeName:
              page = NewWorkoutPage();
              break;
            default:
              page = HomePage(routeName: settings.name ?? "");
              break;
          }
        }
        return MaterialPageRoute(
          builder: (context) => page,
          settings: settings,
        );
      },
    );
  }
}
