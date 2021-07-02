import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout/screens/home/workout_list.dart';
import 'package:workout/models/workout.dart';
import 'package:workout/theme/theme.dart';

class WorkoutsPage extends StatefulWidget {
  static const routeName = "/workouts";

  @override
  WorkoutsPageState createState() => WorkoutsPageState();
}

class WorkoutsPageState extends State<WorkoutsPage> {
  List<Workout> _workouts = [];

  void _fetchWorkouts() async {
    Iterable response = await json.decode(
      await rootBundle.loadString('assets/json/workouts.json'),
    );
    setState(() {
      _workouts = List<Workout>.from(response.map(
        (workout) => Workout.fromJson(workout),
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    this._fetchWorkouts();
  }

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(top: 48.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your workouts',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  ThemeSwitcher(
                    builder: (context) => IconButton(
                      icon: Icon(
                        ThemeProvider.of(context)!.brightness ==
                                Brightness.light
                            ? Icons.dark_mode_outlined
                            : Icons.dark_mode,
                      ),
                      onPressed: () {
                        ThemeSwitcher.of(context)?.changeTheme(
                          theme: ThemeProvider.of(context)?.brightness ==
                                  Brightness.light
                              ? darkTheme
                              : lightTheme,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextField(
                      decoration:
                          InputDecoration(hintText: "Search for a workout..."),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            WorkoutList(workouts: _workouts),
          ],
        ),
      );
}
