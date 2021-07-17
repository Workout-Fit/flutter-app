import 'dart:async';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter_bloc/graphql_flutter_bloc.dart';
import 'package:graphql/client.dart';
import 'package:workout/api/schema.dart';
import 'package:workout/bloc/workouts_bloc.dart';
import 'package:workout/utils/graphql_client.dart';
import 'package:workout/presentation/workout_icons.dart';
import 'package:workout/screens/workout_master_detail/workout.dart';
import 'package:workout/screens/workout_master_detail/workout_master_detail_arguments.dart';
import 'package:workout/theme/theme.dart';
import 'package:workout/widgets/item_card.dart';

class WorkoutsPage extends StatefulWidget {
  static const routeName = "/workouts";

  @override
  _WorkoutsPageState createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  Completer<void> _refreshCompleter = Completer<void>();
  late WorkoutsBloc workoutsBloc;

  @override
  void initState() {
    super.initState();
    workoutsBloc = WorkoutsBloc(client: client)
      ..run(
        variables: GetWorkoutsByUserIdArguments(
          userId: '9500843d-f7f9-4eb2-ae4d-2208dc57e7dc',
        ).toJson(),
      );
  }

  Future _handleRefreshStart() {
    workoutsBloc.refetch();
    return _refreshCompleter.future;
  }

  void _handleRefreshEnd() {
    _refreshCompleter.complete();
    _refreshCompleter = Completer();
  }

  @override
  void dispose() {
    workoutsBloc.dispose();
    super.dispose();
  }

  Widget _workoutList(GetWorkoutsByUserId$Query? data, QueryResult? result) {
    if (data == null) {
      return Container();
    }

    final workouts = data.getWorkoutsByUserId;
    if (data.getWorkoutsByUserId?.length == 0) {
      return Flexible(
        child: Center(
          child: Text("No workouts were found."),
        ),
      );
    } else {
      return Flexible(
        child: RefreshIndicator(
          onRefresh: _handleRefreshStart,
          child: ListView.separated(
            padding: EdgeInsets.only(bottom: 32.0),
            itemCount: workouts?.length ?? 0,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 16.0,
            ),
            itemBuilder: (BuildContext context, int index) => ItemCard(
              label: [
                Icon(
                  WorkoutIcons.barbell,
                  size: 16.0,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  workouts?[index]?.exercises?.length.toString() ?? '0',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
              onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
                WorkoutMasterDetailPage.routeName,
                arguments: WorkoutMasterDetailArguments(
                  workoutId: workouts?[index]?.id ?? '',
                ),
              ),
              title: workouts?[index]?.name ?? '',
              subtitle: workouts?[index]?.muscleGroups?.join(", ") ?? '',
            ),
          ),
        ),
      );
    }
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
            BlocBuilder<WorkoutsBloc, QueryState<GetWorkoutsByUserId$Query>>(
              bloc: workoutsBloc,
              builder: (_, state) {
                if (state is! QueryStateRefetch) {
                  _handleRefreshEnd();
                }

                return state.when(
                  initial: () => Container(),
                  error: (error, __) => Text(parseOperationException(error)),
                  loading: (_) => Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        semanticsLabel: "Loading workout",
                      ),
                    ),
                  ),
                  loaded: _workoutList,
                  refetch: _workoutList,
                  fetchMore: _workoutList,
                );
              },
            ),
          ],
        ),
      );
}
