import 'package:flutter/material.dart';

class WorkoutForm extends StatefulWidget {
  const WorkoutForm({Key? key}) : super(key: key);

  @override
  _WorkoutFormState createState() => _WorkoutFormState();
}

class _WorkoutFormState extends State<WorkoutForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Form(
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
}
