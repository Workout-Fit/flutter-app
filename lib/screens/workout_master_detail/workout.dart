import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:workout/api/schema.dart';
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
  bool _editMode = false;

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

  Future<dynamic> showAddExerciseModal(context) =>
      showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => ExerciseForm(
          onSubmit: (GetWorkoutById$Query$GetWorkoutById$Exercises exercise) {},
        ),
      );

  Future<dynamic> showShareWorkoutModal(context, String workoutId) {
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
                  data: workoutId,
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

  Widget _workoutInfo(GetWorkoutById$Query$GetWorkoutById workout) {
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
                Text(workout.name,
                    style: Theme.of(context).textTheme.headline3),
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

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          if (_editMode && widget.workoutId != null) {
            setState(() {
              _editMode = true;
            });
            return false;
          }
          return true;
        },
        child: Query(
          options: QueryOptions(
            document: GET_WORKOUT_BY_ID_QUERY_DOCUMENT,
            variables: <String, dynamic>{'id': widget.workoutId},
          ),
          builder: (
            QueryResult result, {
            VoidCallback? refetch,
            FetchMore? fetchMore,
          }) =>
              Scaffold(
            backgroundColor:
                ThemeProvider.of(context)?.brightness == Brightness.light
                    ? Colors.white
                    : Colors.black,
            body: Container(
              margin: EdgeInsets.only(top: 48.0),
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
                        if (_editMode)
                          Text(
                            "Edit workout",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        if (!result.isLoading)
                          Flexible(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: _editMode
                                  ? IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.save),
                                    )
                                  : PopupMenuButton<String>(
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
                                      ],
                                      onSelected: (value) {
                                        if (value == "share") {
                                          showShareWorkoutModal(
                                            context,
                                            result.data?['getWorkoutById']
                                                ['id'],
                                          );
                                        }
                                      },
                                      icon: const Icon(Icons.more_vert),
                                    ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  if (result.isLoading)
                    Container(
                      child: Flexible(
                        child: Center(
                          child: CircularProgressIndicator(
                            semanticsLabel: "Loading workout",
                          ),
                        ),
                      ),
                    )
                  else ...<Widget>[
                    _editMode
                        ? buildEditForm()
                        : _workoutInfo(
                            GetWorkoutById$Query$GetWorkoutById.fromJson(
                              result.data?['getWorkoutById'],
                            ),
                          ),
                    if (_editMode)
                      BlockButton(
                        icon: Icons.add,
                        onTap: () {
                          showAddExerciseModal(context);
                        },
                        label: "ADD EXERCISE",
                      ),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
}
