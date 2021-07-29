import 'package:flutter/material.dart';
import 'package:workout/api/schema.graphql.dart';
import 'package:workout/widgets/block_button.dart';

import 'exercise_form.dart';
import 'exercise_list.dart';

class WorkoutForm extends StatelessWidget {
  final List<WorkoutDetailsMixin$Exercises> exercises;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final Function(int index) onExerciseDismissed;
  final Function(WorkoutDetailsMixin$Exercises exercise) onSubmitExercise;

  const WorkoutForm({
    Key? key,
    required this.nameController,
    required this.descriptionController,
    required this.onSubmitExercise,
    required this.onExerciseDismissed,
    this.exercises = const [],
  }) : super(key: key);

  Future<dynamic> _showAddExerciseModal(BuildContext context) {
    return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return ExerciseForm(
          onSubmit: (WorkoutDetailsMixin$Exercises exercise) {
            Navigator.pop(context);
            onSubmitExercise(exercise);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Workout name (required)",
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Workout name required.";
                return null;
              },
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: "Description (Optional), max. 140 characters.",
                hintMaxLines: 2,
              ),
              maxLines: 3,
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text(
              "Exercises",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          const SizedBox(height: 8.0),
          ExerciseList(
            exercises: exercises,
            dismissible: true,
            onDismissed: onExerciseDismissed,
          ),
          BlockButton(
            icon: Icons.add,
            onTap: () => _showAddExerciseModal(context),
            label: "ADD EXERCISE",
          ),
        ],
      ),
    );
  }
}
