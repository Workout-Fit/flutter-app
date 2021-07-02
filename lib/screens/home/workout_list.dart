import 'package:flutter/material.dart';
import 'package:workout/screens/workout_master_detail/index.dart';
import 'package:workout/screens/workout_master_detail/workout_master_detail_arguments.dart';
import 'package:workout/widgets/workout_card.dart';
import 'package:workout/models/workout.dart';

class WorkoutList extends StatelessWidget {
  final List<Workout>? workouts;

  const WorkoutList({Key? key, this.workouts = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) => workouts!.length > 0
      ? Flexible(
          child: ListView.separated(
            padding: EdgeInsets.only(bottom: 32.0),
            itemCount: workouts!.length,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 16.0,
            ),
            itemBuilder: (BuildContext context, int index) => WorkoutCard(
              workout: workouts![index],
              onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
                WorkoutMasterDetailPage.routeName,
                arguments: WorkoutMasterDetailArguments(
                  readOnly: true,
                  workoutId: workouts![index].id,
                ),
              ),
            ),
          ),
        )
      : Flexible(
          child: Center(
            child: Text("No workouts were found."),
          ),
        );
}
