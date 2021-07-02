import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout/models/workout.dart';
import 'package:workout/widgets/block_button.dart';

import 'exercise_form.dart';

class WorkoutMasterDetailPage extends StatefulWidget {
  static const routeName = "/workout";
  final String? workoutId;
  final bool readOnly;

  const WorkoutMasterDetailPage({
    Key? key,
    this.workoutId,
    required this.readOnly,
  }) : super(key: key);

  @override
  _WorkoutMasterDetailPageState createState() =>
      _WorkoutMasterDetailPageState();
}

class _WorkoutMasterDetailPageState extends State<WorkoutMasterDetailPage> {
  final _formKey = GlobalKey<FormState>();
  bool _readOnly = true;
  Workout? _workout;

  @override
  void initState() {
    super.initState();
    _readOnly = widget.readOnly;
    if (widget.workoutId != null) _fetchWorkout();
  }

  void _fetchWorkout() async {
    Iterable response = await json.decode(
      await rootBundle.loadString('assets/json/workouts.json'),
    );
    setState(() {
      _workout = Workout.fromJson(
        response.where((data) => data["workout_id"] == widget.workoutId).first,
      );
    });
  }

  Widget buildForm() => Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(hintText: "Workout name"),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Workout name required.";
                  return null;
                },
              ),
              SizedBox(height: 24.0),
              TextFormField(
                decoration: InputDecoration(
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
        builder: (BuildContext context) => ExerciseForm(onSubmit: () {}),
      );

  Widget buildReadOnly() => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: _workout != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (_workout?.authorId != "user_id")
                    Text(
                      "Created by ${_workout?.authorId}",
                      style: Theme.of(context).textTheme.caption,
                    )
                  else if (_workout?.basedOn != null)
                    Text(
                      "Created by ${_workout?.basedOn}",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  Text(_workout!.name,
                      style: Theme.of(context).textTheme.headline3),
                  SizedBox(height: 16),
                  Text(_workout!.description),
                ],
              )
            : null,
      );

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          if (!_readOnly && widget.workoutId != null) {
            setState(() {
              _readOnly = true;
            });
            return false;
          }
          return true;
        },
        child: Scaffold(
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
                      SizedBox(width: 8.0),
                      if (!_readOnly)
                        Text(
                          "${widget.workoutId != null ? "Edit" : "Add"} workout",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      if (widget.workoutId == null || _workout != null)
                        Flexible(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                  _readOnly ? Icons.more_vert : Icons.save),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                if (widget.workoutId != null && _workout == null)
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
                  _readOnly ? buildReadOnly() : buildForm(),
                  SizedBox(height: 24.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Exercises",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Flexible(
                    child: Container(
                      color: ThemeProvider.of(context)?.brightness ==
                              Brightness.light
                          ? Theme.of(context).backgroundColor
                          : Colors.white.withOpacity(0.05),
                      child: Center(
                        child: Text("No exercises"),
                      ),
                    ),
                  ),
                  if (!_readOnly)
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
      );
}
