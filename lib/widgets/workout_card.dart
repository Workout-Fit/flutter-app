import 'package:flutter/material.dart';
import 'package:workout/models/workout.dart';
import 'package:workout/presentation/workout_icons.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final EdgeInsets margin;
  final void Function()? onTap;

  const WorkoutCard({
    Key? key,
    required this.workout,
    required this.onTap,
    this.margin = const EdgeInsets.symmetric(horizontal: 16.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: this.margin,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: onTap,
            child: Ink(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        workout.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            WorkoutIcons.barbell,
                            size: 16.0,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "10",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Panturrilha, peito",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
