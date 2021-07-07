import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:workout/api/schema.dart';
import 'package:workout/widgets/item_card.dart';

class ExerciseList extends StatelessWidget {
  final List<WorkoutMasterDetailMixin$Exercises?> exercises;
  const ExerciseList({Key? key, required this.exercises}) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
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
                    return SizedBox(height: 16.0);
                  },
                  itemBuilder: (BuildContext context, int index) => ItemCard(
                      title: exercises[index]?.exercise?.name ?? "",
                      subtitle: "${exercises[index]?.sets} sets, " +
                          "${exercises[index]?.repetitions} repetitions. " +
                          "Rest for ${exercises[index]?.rest}''",
                      label: [
                        Text(
                          exercises[index]?.exercise!.muscleGroup!.name ?? "",
                          style: Theme.of(context).textTheme.subtitle2,
                        )
                      ]),
                ),
        ),
      );
}
