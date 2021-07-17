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
import 'package:workout/bloc/workout_bloc.dart';
import 'package:workout/utils/graphql_client.dart';
import 'package:workout/screens/home/workouts.dart';
import 'package:workout/screens/workout_master_detail/exercise_list.dart';
import 'package:workout/widgets/block_button.dart';
import 'exercise_form.dart';

class WorkoutMasterDetailPage extends StatefulWidget {
  static const routeName = "/workout";
  final String? workoutId;
  final bool newWorkout;

  const WorkoutMasterDetailPage({
    Key? key,
    this.workoutId,
    required this.newWorkout,
  }) : super(key: key);

  @override
  _WorkoutMasterDetailPageState createState() =>
      _WorkoutMasterDetailPageState();
}

class _WorkoutMasterDetailPageState extends State<WorkoutMasterDetailPage> {
  final _formKey = GlobalKey<FormState>();
  late WorkoutBloc _workoutBloc;
  late DeleteWorkoutBloc _deleteWorkoutBloc;
  bool _editMode = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _workoutBloc = WorkoutBloc(client: client)
      ..run(variables: {'id': widget.workoutId});
    _deleteWorkoutBloc = DeleteWorkoutBloc(client: client);
  }

  @override
  void dispose() {
    _workoutBloc.dispose();
    _deleteWorkoutBloc.dispose();
    super.dispose();
  }

  Widget buildEditForm() => Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(hintText: "Workout name"),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Workout name required.";
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Description (Optional), max. 140 characters.",
                  hintMaxLines: 2,
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
      );

  Future<dynamic> showAddExerciseModal() => showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => ExerciseForm(
          onSubmit: (GetWorkoutById$Query$GetWorkoutById$Exercises exercise) {},
        ),
      );

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

  Widget _popupMenu(
    String workoutId,
  ) {
    Widget _deleteButton(bool loading) {
      return AbsorbPointer(
        absorbing: loading,
        child: TextButton(
          onPressed: () {
            _deleteWorkoutBloc
                .run(DeleteWorkoutArguments(id: workoutId).toJson());
            setState(() {
              _isLoading = true;
            });
            Navigator.of(context).pop();
          },
          child: Text("Delete"),
        ),
      );
    }

    return PopupMenuButton<String>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "share",
          child: Row(
            children: <Widget>[
              const Icon(Icons.share_outlined),
              const Text('Share Workout'),
            ],
          ),
        ),
        PopupMenuItem(
          value: "delete",
          child: Row(
            children: <Widget>[
              const Icon(Icons.delete_outline),
              const Text('Delete Workout'),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        if (value == "share") {
          showShareWorkoutModal(workoutId);
        } else if (value == "delete") {
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
                  BlocListener<DeleteWorkoutBloc,
                      MutationState<DeleteWorkout$Mutation>>(
                    bloc: _deleteWorkoutBloc,
                    listener: (context, state) {
                      state.maybeWhen(
                        completed: (_, __) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text('Workout deleted'),
                          ));
                          Navigator.of(context, rootNavigator: true).popUntil(
                            ModalRoute.withName(WorkoutsPage.routeName),
                          );
                        },
                        orElse: () => {},
                      );
                    },
                    child: BlocBuilder<DeleteWorkoutBloc,
                        MutationState<DeleteWorkout$Mutation>>(
                      bloc: _deleteWorkoutBloc,
                      builder: (_, state) {
                        return state.when(
                          initial: () => _deleteButton(false),
                          loading: () => _deleteButton(true),
                          error: (_, __) => _deleteButton(false),
                          completed: (data, result) => _deleteButton(false),
                        );
                      },
                    ),
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
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios),
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
                              onPressed: () {},
                              icon: Icon(Icons.save),
                            )
                          : _popupMenu(workout.id);
                    } else
                      return Text('');
                  }()),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        _editMode ? buildEditForm() : _workoutDetails(workout!),
        if (_editMode)
          BlockButton(
            icon: Icons.add,
            onTap: () {
              showAddExerciseModal();
            },
            label: "ADD EXERCISE",
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_editMode && widget.workoutId != null) {
          setState(() {
            _editMode = true;
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
                              onPressed: () => Navigator.pop(context),
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
    );
  }
}
