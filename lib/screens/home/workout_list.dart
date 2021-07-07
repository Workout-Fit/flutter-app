import 'package:flutter/material.dart';
import 'package:workout/api/schema.dart';
import 'package:workout/presentation/workout_icons.dart';
import 'package:workout/screens/workout_master_detail/workout.dart';
import 'package:workout/screens/workout_master_detail/workout_master_detail_arguments.dart';
import 'package:workout/widgets/item_card.dart';

class WorkoutList extends StatelessWidget {
  final List<GetWorkoutsByUserId$Query$GetWorkoutsByUserId>? workouts;

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
                  workouts![index].exercises!.length.toString(),
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
              onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
                WorkoutMasterDetailPage.routeName,
                arguments: WorkoutMasterDetailArguments(
                  workoutId: workouts![index].id,
                ),
              ),
              title: workouts![index].name,
              subtitle: workouts![index].muscleGroups!.join(", "),
            ),
          ),
        )
      : Flexible(
          child: Center(
            child: Text("No workouts were found."),
          ),
        );
}
