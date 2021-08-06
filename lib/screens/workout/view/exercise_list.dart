import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:workout/api/schema.graphql.dart';
import 'package:workout/widgets/item_card.dart';

class ExerciseList extends StatelessWidget {
  final List<WorkoutDetailsMixin$Exercises?> exercises;
  final bool dismissible;
  final Function(int index)? onDismissed;

  const ExerciseList({
    Key? key,
    required this.exercises,
    this.dismissible = false,
    this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: ThemeProvider.of(context)?.brightness == Brightness.light
            ? Theme.of(context).backgroundColor
            : Colors.white.withOpacity(0.05),
        child: exercises.length == 0
            ? Center(child: Text("No exercises"))
            : ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                itemCount: exercises.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 16.0);
                },
                itemBuilder: (BuildContext context, int index) {
                  return ItemCard(
                    key: UniqueKey(),
                    title: exercises[index]?.exercise.name ?? "",
                    subtitle: "${exercises[index]?.sets} sets, " +
                        "${exercises[index]?.repetitions} repetitions. " +
                        "Rest for ${exercises[index]?.rest}''",
                    dismissible: dismissible,
                    onDismissed: (DismissDirection direction) {
                      if (onDismissed != null) {
                        onDismissed!(index);
                      }
                    },
                    label: [
                      Text(
                        exercises[index]?.exercise.muscleGroup.name ?? "",
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ],
                  );
                },
              ),
      ),
    );
  }
}
