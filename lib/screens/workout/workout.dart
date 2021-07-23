import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter_bloc/graphql_flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:workout/api/schema.dart';
import 'package:workout/bloc/delete_workout_bloc.dart';
import 'package:workout/bloc/update_workout_bloc.dart';
import 'package:workout/bloc/workout_bloc.dart';
import 'package:workout/screens/workout/workout_form.dart';
import 'package:workout/utils/graphql_client.dart';
import 'package:workout/screens/home/workouts.dart';
import 'package:workout/screens/workout/exercise_list.dart';

class WorkoutPage extends StatefulWidget {
  static const routeName = "/workout";
  final String? workoutId;

  const WorkoutPage({
    Key? key,
    this.workoutId,
  }) : super(key: key);

  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final _formKey = GlobalKey<FormState>();
  late WorkoutBloc _workoutBloc;
  late DeleteWorkoutBloc _deleteWorkoutBloc;
  late UpdateWorkoutBloc _updateWorkoutBloc;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<WorkoutDetailsMixin$Exercises> _exercises = [];
  bool _editMode = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _workoutBloc = WorkoutBloc(client: client)
      ..run(variables: {'id': widget.workoutId});
    _deleteWorkoutBloc = DeleteWorkoutBloc(client: client);
    _updateWorkoutBloc = UpdateWorkoutBloc(client: client);
  }

  @override
  void dispose() {
    _workoutBloc.dispose();
    _deleteWorkoutBloc.dispose();
    _updateWorkoutBloc.dispose();
    super.dispose();
  }

  Widget _editForm(GetWorkoutById$Query$GetWorkoutById workout) {
    return WorkoutForm(
      key: _formKey,
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
                  },
                ),
              ),
            );
        });
      },
    );
  }

  Future<dynamic> showShareWorkoutModal(String workoutId) {
    return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Edit workout",
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 32.0),
                QrImage(
                  data: "http://workout.app/view/$workoutId",
                  padding: EdgeInsets.zero,
                  foregroundColor:
                      ThemeProvider.of(context)?.brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                  version: QrVersions.auto,
                ),
                const SizedBox(height: 32.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 250.0,
                      child: Text(
                        "http://workout.app/view/$workoutId",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(
                            text: "http://workout.app/view/$workoutId",
                          ),
                        );
                        Fluttertoast.showToast(
                            msg: "Copied to clipboard",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                      icon: Icon(Icons.copy),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _workoutDetails(GetWorkoutById$Query$GetWorkoutById workout) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (workout.userId != "user_id")
                  Text(
                    "Created by ${workout.basedOn?.user?.username ?? ""}",
                    style: Theme.of(context).textTheme.caption,
                  )
                else if (workout.basedOn != null)
                  Text(
                    "Based on ${workout.basedOn?.user?.username ?? ""}",
                    style: Theme.of(context).textTheme.caption,
                  ),
                Text(
                  workout.name,
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(height: 16),
                Text(workout.description ?? ""),
                const SizedBox(height: 24.0),
                Text(
                  "Exercises",
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
          ExerciseList(exercises: workout.exercises ?? [])
        ],
      ),
    );
  }

  Widget _popupMenu(GetWorkoutById$Query$GetWorkoutById workout) {
    return PopupMenuButton<String>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "share",
          child: Row(
            children: <Widget>[
              const Icon(Icons.share_outlined),
              SizedBox(width: 16.0),
              const Text('Share Workout'),
            ],
          ),
        ),
        PopupMenuItem(
          value: "edit",
          child: Row(
            children: <Widget>[
              const Icon(Icons.edit_outlined),
              SizedBox(width: 16.0),
              const Text('Edit Workout'),
            ],
          ),
        ),
        PopupMenuItem(
          value: "delete",
          child: Row(
            children: <Widget>[
              const Icon(Icons.delete_outline),
              SizedBox(width: 16.0),
              const Text('Delete Workout'),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        if (value == "share")
          showShareWorkoutModal(workout.id);
        else if (value == "edit")
          setState(() {
            _nameController.text = workout.name;
            _descriptionController.text = workout.description ?? '';
            _exercises = List.from(workout.exercises ?? []);
            _editMode = true;
          });
        else if (value == "delete") {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: Text("Delete Workout"),
                content: Text(
                  "Are you sure you want to delete this workout?",
                ),
                actions: [
                  TextButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      _deleteWorkoutBloc.run(
                        DeleteWorkoutArguments(id: workout.id).toJson(),
                      );
                    },
                    child: Text("Delete"),
                  ),
                ],
              );
            },
          );
        }
      },
      icon: const Icon(Icons.more_vert),
    );
  }

  Widget _workoutInfo(GetWorkoutById$Query? data, QueryResult? result) {
    if (data == null) {
      return Container();
    }

    final workout = data.getWorkoutById;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: Icon(_editMode ? Icons.close : Icons.arrow_back_ios),
              ),
              const SizedBox(width: 8.0),
              if (_editMode)
                Text(
                  "Edit workout",
                  style: Theme.of(context).textTheme.headline4,
                ),
              Flexible(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: (() {
                    if (workout!.userId ==
                        '9500843d-f7f9-4eb2-ae4d-2208dc57e7dc') {
                      return _editMode
                          ? IconButton(
                              onPressed: () {
                                _updateWorkoutBloc.run(
                                  UpdateWorkoutArguments(
                                    workout: WorkoutInput(
                                      id: workout.id,
                                      name: _nameController.text,
                                      userId:
                                          '9500843d-f7f9-4eb2-ae4d-2208dc57e7dc',
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
                              },
                              icon: const Icon(Icons.save),
                            )
                          : _popupMenu(workout);
                    } else
                      return Text('');
                  }()),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        _editMode ? _editForm(workout!) : _workoutDetails(workout!),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_editMode) {
          setState(() {
            _editMode = false;
          });
          return false;
        }
        return true;
      },
      child: LoadingOverlay(
        isLoading: _isLoading,
        child: Scaffold(
          backgroundColor:
              ThemeProvider.of(context)?.brightness == Brightness.light
                  ? Colors.white
                  : Colors.black,
          body: Container(
            margin: EdgeInsets.only(top: 48.0),
            child: MultiBlocListener(
              listeners: [
                BlocListener<DeleteWorkoutBloc,
                    MutationState<DeleteWorkout$Mutation>>(
                  bloc: _deleteWorkoutBloc,
                  listener: (blocContext, state) {
                    state.maybeWhen(
                      completed: (_, __) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Workout deleted'),
                        ));
                        Navigator.of(context).popUntil(
                          ModalRoute.withName(WorkoutsPage.routeName),
                        );
                      },
                      loading: () {
                        setState(() {
                          _isLoading = true;
                        });
                        Navigator.of(context).pop();
                      },
                      orElse: () => {},
                    );
                  },
                ),
                BlocListener<UpdateWorkoutBloc,
                        MutationState<UpdateWorkout$Mutation>>(
                    bloc: _updateWorkoutBloc,
                    listener: (context, state) {
                      state.maybeWhen(
                        completed: (data, result) {
                          setState(() {
                            _isLoading = false;
                            _editMode = false;
                          });
                        },
                        loading: () {
                          setState(() {
                            _isLoading = true;
                          });
                        },
                        orElse: () => {},
                      );
                    })
              ],
              child: BlocBuilder<WorkoutBloc, QueryState<GetWorkoutById$Query>>(
                bloc: _workoutBloc,
                builder: (_, state) {
                  return state.when(
                    initial: () => Container(),
                    error: (error, __) => Text(parseOperationException(error)),
                    loading: (_) => Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: Icon(Icons.arrow_back_ios),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Flexible(
                            child: Center(
                              child: CircularProgressIndicator(
                                semanticsLabel: "Loading workout",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    loaded: _workoutInfo,
                    refetch: _workoutInfo,
                    fetchMore: _workoutInfo,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
