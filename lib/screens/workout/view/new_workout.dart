import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter_bloc/graphql_flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:workout/api/schema.dart';
import 'package:workout/app/bloc/authentication_bloc.dart';
import 'package:workout/screens/workout/bloc/create_workout_bloc.dart';
import 'package:workout/screens/workout/workout.dart';
import 'package:workout/screens/workout/view/workout_form.dart';
import 'package:workout/utils/graphql_client.dart';

class NewWorkoutPage extends StatefulWidget {
  static const routeName = "new_workout";

  const NewWorkoutPage({Key? key}) : super(key: key);

  @override
  _NewWorkoutPageState createState() => _NewWorkoutPageState();
}

class _NewWorkoutPageState extends State<NewWorkoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<WorkoutDetailsMixin$Exercises> _exercises = [];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      body: LoadingOverlay(
        isLoading: _loading,
        child: Container(
          margin: const EdgeInsets.only(top: 40.0),
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
                                Navigator.of(context).pushReplacementNamed(
                                  WorkoutPage.routeName,
                                  arguments: WorkoutArguments(
                                    workoutId: result.data?['createWorkout']
                                        ['id'],
                                  ),
                                );
                                setState(() {
                                  _loading = false;
                                });
                              },
                              error: (_, result) {
                                print(result.exception);
                                setState(() {
                                  _loading = false;
                                });
                              },
                              loading: () => setState(() {
                                _loading = true;
                              }),
                              orElse: () => {},
                            );
                          },
                          child: IconButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _createWorkoutBloc.run(CreateWorkoutArguments(
                                  workout: WorkoutInput(
                                    name: _nameController.text,
                                    userId: BlocProvider.of<AuthenticationBloc>(
                                      context,
                                    ).state.user.id,
                                    description: _descriptionController.text,
                                    exercises: _exercises
                                        .map(
                                          (exercise) => WorkoutExerciseInput(
                                            exerciseId: exercise.exerciseId,
                                            repetitions: exercise.repetitions,
                                            rest: exercise.rest,
                                            sets: exercise.sets,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ).toJson());
                              }
                            },
                            icon: const Icon(Icons.save),
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
                child: WorkoutForm(
                  onSubmitExercise: (WorkoutDetailsMixin$Exercises exercise) {
                    setState(() {
                      _exercises.add(exercise);
                    });
                  },
                  exercises: _exercises,
                  nameController: _nameController,
                  descriptionController: _descriptionController,
                  onExerciseDismissed: (int index) {
                    setState(() {
                      WorkoutDetailsMixin$Exercises deletedExercise =
                          _exercises.removeAt(index);
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text("Exercise removed"),
                            action: SnackBarAction(
                                label: "UNDO",
                                onPressed: () {
                                  setState(() {
                                    _exercises.insert(
                                      index,
                                      deletedExercise,
                                    );
                                  });
                                }),
                          ),
                        );
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
