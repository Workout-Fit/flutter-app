import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout/api/schema.graphql.dart';
import 'package:workout/screens/workout/view/exercise_list.dart';
import 'package:workout/widgets/item_card.dart';
import 'package:flutter/services.dart';

import 'wrapper.dart';

late List<WorkoutDetailsMixin$Exercises> exercises;

void main() {
  setUp(() async {
    String workoutJson =
        await rootBundle.loadString('assets/json/workout.json');
    exercises = List.from(json.decode(workoutJson)['exercises'])
        .map((exercise) => WorkoutDetailsMixin$Exercises.fromJson(exercise))
        .toList();
  });

  group('Exercise List', () {
    testWidgets(
      'Should render an ItemCard for each Exercise provided',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          Wrapper(
            child: ExerciseList(
              exercises: exercises,
            ),
          ),
        );

        expect(find.byType(ItemCard), findsNWidgets(2));
      },
    );

    testWidgets(
      'Label should be the muscle group',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          Wrapper(
            child: ExerciseList(
              exercises: exercises,
            ),
          ),
        );

        expect(
          find.text(exercises[0].exercise.muscleGroup.name),
          findsOneWidget,
        );
      },
    );

    testWidgets('Can receive dismissible', (WidgetTester tester) async {
      await tester.pumpWidget(
        Wrapper(
          child: ExerciseList(
            exercises: exercises,
            dismissible: true,
            onDismissed: (index) {},
          ),
        ),
      );

      expect(find.byType(Dismissible), findsNWidgets(2));
    });

    testWidgets('Can receive onDismissed', (WidgetTester tester) async {
      int returnValue = -1;
      final onDismissed = (int index) => returnValue = index;

      await tester.pumpWidget(
        Wrapper(
          child: ExerciseList(
            exercises: exercises,
            dismissible: true,
            onDismissed: onDismissed,
          ),
        ),
      );

      await tester.drag(
        find.byType(Dismissible).first,
        const Offset(500.0, 0.0),
      );

      await tester.pumpAndSettle();
      expect(returnValue, 0);
    });
  });
}
