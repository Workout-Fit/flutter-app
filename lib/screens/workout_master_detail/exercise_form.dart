import 'package:flutter/material.dart';

class ExerciseForm extends StatefulWidget {
  final VoidCallback onSubmit;

  const ExerciseForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _ExerciseFormState createState() => _ExerciseFormState();
}

class _ExerciseFormState extends State<ExerciseForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Wrap(
        children: [
          Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add exercise",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: 24.0),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Exercise name",
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Sets",
                          ),
                        ),
                      ),
                      SizedBox(width: 24.0),
                      Flexible(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Reps",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.0),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Break (In seconds)",
                    ),
                  ),
                  SizedBox(height: 24.0),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Notes (Optional) Max. 80 characters",
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 40.0),
                  ElevatedButton(
                    onPressed: widget.onSubmit,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save, color: Colors.white),
                        SizedBox(width: 8.0),
                        Text("SAVE EXERCISE"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
}
