import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:workout/api/schema.dart';
import 'package:workout/screens/home/workout_list.dart';
import 'package:workout/theme/theme.dart';

class WorkoutsPage extends StatelessWidget {
  static const routeName = "/workouts";

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
            Query(
              options: QueryOptions(
                document: GET_WORKOUTS_BY_USER_ID_QUERY_DOCUMENT,
                variables: {'userId': '9500843d-f7f9-4eb2-ae4d-2208dc57e7dc'},
              ),
              builder: (
                QueryResult result, {
                VoidCallback? refetch,
                FetchMore? fetchMore,
              }) =>
                  result.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            semanticsLabel: "Loading workout",
                          ),
                        )
                      : WorkoutList(
                          workouts: List<
                              GetWorkoutsByUserId$Query$GetWorkoutsByUserId>.from(
                            result.data?['getWorkoutsByUserId']?.map(
                                  (workout) =>
                                      GetWorkoutsByUserId$Query$GetWorkoutsByUserId
                                          .fromJson(workout),
                                ) ??
                                [],
                          ),
                        ),
            ),
          ],
        ),
      );
}
