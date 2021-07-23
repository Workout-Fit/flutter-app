import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout/widgets/item_card.dart';

void main() {
  group('Item Card', () {
    testWidgets('Should receive a title', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: ItemCard(title: 'Title'),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('Can receive onTap', (WidgetTester tester) async {
      int timesCalled = 0;
      final onTap = () => timesCalled += 1;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: ItemCard(
            title: '',
            onTap: onTap,
          ),
        ),
      );
      await tester.tap(find.byType(InkWell));

      expect(timesCalled, 1);
    });

    testWidgets('Can receive margin', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: ItemCard(
            title: '',
            margin: EdgeInsets.all(8.0),
          ),
        ),
      );

      expect(
        tester.widget(find.byType(Container).first),
        isA<Container>().having(
          (r) => r.margin,
          'margin',
          EdgeInsets.all(8.0),
        ),
      );
    });

    testWidgets('Can receive subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: ItemCard(
            title: '',
            subtitle: 'Subtitle',
          ),
        ),
      );

      expect(find.text('Subtitle'), findsOneWidget);
    });

    testWidgets('Can receive label', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: ItemCard(
            title: '',
            label: [Icon(Icons.add)],
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('Can receive dismissible', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: ItemCard(
            title: '',
            label: [Icon(Icons.add)],
            dismissible: true,
            key: Key('1'),
          ),
        ),
      );

      expect(find.byType(Dismissible), findsOneWidget);
    });

    testWidgets('Can receive onDismissed', (WidgetTester tester) async {
      int timesCalled = 0;
      final onDismissed = (DismissDirection dir) => timesCalled += 1;

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: ItemCard(
              title: '',
              label: [Icon(Icons.add)],
              dismissible: true,
              key: Key('1'),
              onDismissed: onDismissed),
        ),
      );

      await tester.drag(find.byType(Dismissible), const Offset(500.0, 0.0));

      await tester.pumpAndSettle();
      expect(timesCalled, 1);
    });
  });
}
