import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:workout/api/schema.dart';

class ExerciseForm extends StatefulWidget {
  final void Function(GetWorkoutById$Query$GetWorkoutById$Exercises) onSubmit;

  const ExerciseForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _ExerciseFormState createState() => _ExerciseFormState();
}

class _ExerciseFormState extends State<ExerciseForm> {
  final _formKey = GlobalKey<FormState>();
  final _setsController = TextEditingController();
  final _breakController = TextEditingController();
  final _repetitionsController = TextEditingController();
  SearchExercises$Query$GetExercises? _selectedExercise;

  Future<List<SearchExercises$Query$GetExercises>> fetchExercises(
    filter,
    context,
  ) async {
    QueryResult result = await GraphQLProvider.of(context).value.query(
          QueryOptions(
            document: SEARCH_EXERCISES_QUERY_DOCUMENT,
            variables: {"exerciseName": filter},
          ),
        );
    return List<SearchExercises$Query$GetExercises>.from(
        result.data?['getExercises'].map((exercise) =>
            (SearchExercises$Query$GetExercises.fromJson(exercise)))).toList();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
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
                  const SizedBox(height: 24.0),
                  DropdownSearch<SearchExercises$Query$GetExercises>(
                    hint: "Search Exercise",
                    validator: (v) => v == null ? "Select an exercise." : null,
                    popupShape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    onChanged: (data) {
                      setState(() {
                        _selectedExercise = data;
                      });
                    },
                    showSearchBox: true,
                    onFind: (String filter) async =>
                        fetchExercises(filter, context),
                    dropdownSearchDecoration: const InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                    ),
                    popupItemBuilder: (
                      context,
                      SearchExercises$Query$GetExercises? item,
                      index,
                    ) {
                      return Container(
                        child: ListTile(
                          title: Text(item?.name ?? ""),
                          subtitle: Text(item?.muscleGroup?.name ?? ""),
                        ),
                      );
                    },
                    dropdownBuilder: (
                      context,
                      SearchExercises$Query$GetExercises? item,
                      index,
                    ) {
                      return Text(
                        item?.name ?? "Select an exercise",
                        style: Theme.of(context).textTheme.subtitle1,
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                    showClearButton: true,
                    isFilteredOnline: true,
                    searchBoxDecoration: InputDecoration(
                      hintText: "Search for an exercise",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _setsController,
                          validator: (value) => value == null || value.isEmpty
                              ? "Sets required"
                              : null,
                          decoration: const InputDecoration(
                            hintText: "Sets",
                          ),
                        ),
                      ),
                      const SizedBox(width: 24.0),
                      Flexible(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _repetitionsController,
                          validator: (value) => value == null || value.isEmpty
                              ? "Repetitions required"
                              : null,
                          decoration: const InputDecoration(
                            hintText: "Repetitions",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: _breakController,
                    validator: (value) => value == null || value.isEmpty
                        ? "Break time required"
                        : null,
                    decoration: const InputDecoration(
                      hintText: "Break (In seconds)",
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onSubmit(
                          GetWorkoutById$Query$GetWorkoutById$Exercises
                              .fromJson(
                            {
                              'exerciseId': _selectedExercise!.id,
                              'repetitions':
                                  int.parse(_repetitionsController.text),
                              'rest': int.parse(_breakController.text),
                              'sets': int.parse(_setsController.text),
                              'exercise': _selectedExercise!.toJson(),
                            },
                          ),
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.save, color: Colors.white),
                        const SizedBox(width: 8.0),
                        const Text("SAVE EXERCISE"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
