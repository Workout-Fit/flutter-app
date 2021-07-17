import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter_bloc/graphql_flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:workout/api/schema.dart';
import 'package:workout/bloc/create_workout_bloc.dart';
import 'package:workout/screens/home/workouts.dart';
import 'package:workout/screens/workout_master_detail/exercise_list.dart';
import 'package:workout/screens/workout_master_detail/workout.dart';
import 'package:workout/screens/workout_master_detail/workout_master_detail_arguments.dart';
import 'package:workout/utils/graphql_client.dart';
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
  final CreateWorkoutBloc _createWorkoutBloc =
      CreateWorkoutBloc(client: client);
  bool _loading = false;

  @override
  void dispose() {
    _createWorkoutBloc.dispose();
    super.dispose();
  }

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

  Widget _saveButton(bool loading) {
    return AbsorbPointer(
      absorbing: loading,
      child: IconButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _createWorkoutBloc.run(
              CreateWorkoutArguments(
                workout: WorkoutInput(
                  name: _nameController.text,
                  userId: '9500843d-f7f9-4eb2-ae4d-2208dc57e7dc',
                  description: _descriptionController.text,
                  exercises: _exercises
                      .map(
                        (exercise) => ExercisesInput(
                          exerciseId: exercise.exerciseId,
                          repetitions: exercise.repetitions,
                          rest: exercise.rest,
                          sets: exercise.sets,
                        ),
                      )
                      .toList(),
                ),
              ).toJson(),
            );
          }
        },
        icon: const Icon(Icons.save),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor:
            ThemeProvider.of(context)?.brightness == Brightness.light
                ? Colors.white
                : Colors.black,
        body: LoadingOverlay(
          isLoading: _loading,
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
                          child: BlocListener<CreateWorkoutBloc,
                              MutationState<CreateWorkout$Mutation>>(
                            bloc: _createWorkoutBloc,
                            listener: (_, state) {
                              state.maybeWhen(
                                completed: (_, result) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Workout created'),
                                    ),
                                  );
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    WorkoutMasterDetailPage.routeName,
                                    ModalRoute.withName(WorkoutsPage.routeName),
                                    arguments: WorkoutMasterDetailArguments(
                                      workoutId: result.data?['createWorkout']
                                          ['id'],
                                    ),
                                  );
                                  setState(() {
                                    _loading = false;
                                  });
                                },
                                error: (_, __) => setState(() {
                                  _loading = false;
                                }),
                                loading: () => setState(() {
                                  _loading = true;
                                }),
                                orElse: () => {},
                              );
                            },
                            child: BlocBuilder<CreateWorkoutBloc,
                                MutationState<CreateWorkout$Mutation>>(
                              bloc: _createWorkoutBloc,
                              builder: (_, state) {
                                return state.when(
                                  initial: () => _saveButton(false),
                                  loading: () => _saveButton(true),
                                  error: (_, __) => _saveButton(false),
                                  completed: (_, __) => _saveButton(false),
                                );
                              },
                            ),
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
        ),
      );
}
