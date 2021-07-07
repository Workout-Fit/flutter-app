import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workout/api/schema.dart';
import 'package:workout/screens/workout_master_detail/exercise_list.dart';
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
  final List<WorkoutMasterDetailMixin$Exercises> _exercises = [];

  Future<dynamic> showAddExerciseModal(context) =>
      showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return ExerciseForm(
              onSubmit: (WorkoutMasterDetailMixin$Exercises exercise) {
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
                    Text(
                      "Add workout",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Flexible(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.save),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Form(
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
                          hintText:
                              "Description (Optional), max. 140 characters.",
                          hintMaxLines: 2,
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  "Exercises",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              SizedBox(height: 8.0),
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
}
