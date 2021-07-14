import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:workout/api/schema.dart';
import 'package:workout/screens/workout_master_detail/exercise_list.dart';
import 'package:workout/screens/workout_master_detail/workout.dart';
import 'package:workout/screens/workout_master_detail/workout_master_detail_arguments.dart';
import 'package:workout/widgets/block_button.dart';
import 'exercise_form.dart';

class NewWorkoutPage extends StatefulWidget {
  static const routeName = "/workout/new";

  const NewWorkoutPage({Key? key}) : super(key: key);

  @override
  _NewWorkoutPageState createState() => _NewWorkoutPageState();
}

class _NewWorkoutPageState extends State<NewWorkoutPage> {
  final _formKey = GlobalKey<FormState>();
  final List<GetWorkoutById$Query$GetWorkoutById$Exercises> _exercises = [];
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future<dynamic> showAddExerciseModal(context) =>
      showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return ExerciseForm(onSubmit:
              (GetWorkoutById$Query$GetWorkoutById$Exercises exercise) {
            setState(() {
              _exercises.add(exercise);
              Navigator.pop(context);
            });
          });
        },
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor:
            ThemeProvider.of(context)?.brightness == Brightness.light
                ? Colors.white
                : Colors.black,
        body: Mutation(
          options: MutationOptions(
            document: CREATE_WORKOUT_MUTATION_DOCUMENT,
            onCompleted: (dynamic resultData) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text('Workout created'),
              ));
              Navigator.of(context, rootNavigator: true).pushNamed(
                WorkoutMasterDetailPage.routeName,
                arguments: WorkoutMasterDetailArguments(
                  workoutId: resultData['createWorkout']['id'],
                ),
              );
            },
          ),
          builder: (RunMutation runMutation, QueryResult? result) {
            return LoadingOverlay(
              isLoading: result?.isLoading ?? false,
              child: Container(
                margin: const EdgeInsets.only(top: 48.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.arrow_back_ios),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            "Add workout",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Flexible(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    runMutation({
                                      'workout': WorkoutInput(
                                        name: _nameController.text,
                                        userId:
                                            '9500843d-f7f9-4eb2-ae4d-2208dc57e7dc',
                                        description:
                                            _descriptionController.text,
                                        exercises: _exercises
                                            .map(
                                              (exercise) => ExercisesInput(
                                                exerciseId: exercise.exerciseId,
                                                repetitions:
                                                    exercise.repetitions,
                                                rest: exercise.rest,
                                                sets: exercise.sets,
                                              ),
                                            )
                                            .toList(),
                                      ).toJson()
                                    });
                                  }
                                },
                                icon: const Icon(Icons.save),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: "Workout name",
                              ),
                              controller: _nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return "Workout name required.";
                                return null;
                              },
                            ),
                            const SizedBox(height: 24.0),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText:
                                    "Description (Optional), max. 140 characters.",
                                hintMaxLines: 2,
                              ),
                              controller: _descriptionController,
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        "Exercises",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    ExerciseList(exercises: _exercises),
                    BlockButton(
                      icon: Icons.add,
                      onTap: () {
                        showAddExerciseModal(context);
                      },
                      label: "ADD EXERCISE",
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
}
