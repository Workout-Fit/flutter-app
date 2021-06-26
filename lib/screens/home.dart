import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:workout/routes.dart';
import 'package:workout/screens/profile.dart';
import 'package:workout/screens/workouts.dart';
import 'package:workout/theme/theme.dart';

class HomePage extends StatefulWidget {
  final String routeName;

  const HomePage({Key? key, required this.routeName}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  int _navigationSelectedIndex = 0;
  ValueNotifier<bool> _dialOpen = ValueNotifier(false);

  Route _onGenerateRoute(RouteSettings settings) => MaterialPageRoute(
        builder: (context) =>
            settings.name == routeProfile ? ProfilePage() : WorkoutsPage(),
        settings: settings,
      );

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
          initialRoute: widget.routeName,
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
                    labelStyle: TextStyle(
                      color: mediumEmphasisBlack,
                    ),
                    foregroundColor: mediumEmphasisBlack,
                    child: Icon(Icons.add),
                    label: "Add Workout",
                  ),
                  SpeedDialChild(
                    onTap: () {
                      Navigator.pushNamed(context, routeQRScan);
                    },
                    labelStyle: TextStyle(
                      color: mediumEmphasisBlack,
                    ),
                    foregroundColor: mediumEmphasisBlack,
                    child: Icon(Icons.qr_code_scanner),
                    label: "Import Workout",
                  ),
                ],
              )
            : null,
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "Workouts",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
          onTap: (int index) {
            if (_navigationSelectedIndex != index) {
              switch (index) {
                case 0:
                  _navigatorKey.currentState!.pushNamed(routeWorkoutList);
                  break;
                case 1:
                  _navigatorKey.currentState!.pushNamed(routeProfile);
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
