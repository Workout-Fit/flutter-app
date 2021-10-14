import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:workout/presentation/workout_icons.dart';
import 'package:workout/screens/scan_qr/view/scan_qr.dart';
import 'package:workout/screens/workout/workout.dart';

import 'profile.dart';
import 'workouts.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home';
  final String subRouteName;

  const HomePage({Key? key, required this.subRouteName}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  int _navigationSelectedIndex = 0;
  ValueNotifier<bool> _dialOpen = ValueNotifier(false);

  Route _onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => settings.name == ProfilePage.routeName
          ? ProfilePage()
          : WorkoutsPage(),
      settings: settings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_dialOpen.value) {
          _dialOpen.value = false;
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Navigator(
          key: _navigatorKey,
          initialRoute: widget.subRouteName,
          onGenerateRoute: _onGenerateRoute,
        ),
        floatingActionButton: _navigationSelectedIndex == 0
            ? SpeedDial(
                icon: Icons.add,
                activeIcon: Icons.close,
                overlayColor: Colors.black,
                overlayOpacity: 0.3,
                openCloseDial: _dialOpen,
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                children: [
                  SpeedDialChild(
                    onTap: () => Navigator.pushNamed(
                      context,
                      NewWorkoutPage.routeName,
                    ),
                    child: const Icon(Icons.add),
                    label: "Add Workout",
                  ),
                  SpeedDialChild(
                    onTap: () =>
                        Navigator.pushNamed(context, ScanQRPage.routeName),
                    child: const Icon(Icons.qr_code_scanner),
                    label: "Import Workout",
                  ),
                ],
              )
            : null,
        bottomNavigationBar: BottomNavigationBar(
          items: [
            const BottomNavigationBarItem(
              icon: const Icon(WorkoutIcons.barbell),
              label: "Workouts",
            ),
            const BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: "Profile",
            ),
          ],
          onTap: (int index) {
            if (_navigationSelectedIndex != index) {
              switch (index) {
                case 0:
                  _navigatorKey.currentState!.pushNamed(WorkoutsPage.routeName);
                  break;
                case 1:
                  _navigatorKey.currentState!.pushNamed(ProfilePage.routeName);
                  break;
              }
            }
            setState(() {
              _navigationSelectedIndex = index;
            });
          },
          currentIndex: _navigationSelectedIndex,
        ),
      ),
    );
  }
}
