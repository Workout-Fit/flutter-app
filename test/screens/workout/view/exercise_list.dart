import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout/api/schema.graphql.dart';
import 'package:workout/screens/workout/view/exercise_list.dart';
import 'package:workout/widgets/item_card.dart';
import 'package:flutter/services.dart';

late List<WorkoutDetailsMixin$Exercises> exercises;

class Wrapper extends StatelessWidget {
  final Widget child;

  const Wrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Flex(direction: Axis.vertical, children: <Widget>[child]),
      ),
    );
  }
}

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
          find.text(exercises[0].exercise!.muscleGroup!.name),
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
