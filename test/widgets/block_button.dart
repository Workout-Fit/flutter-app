import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout/widgets/block_button.dart';

void main() {
  group('Block button', () {
    testWidgets('Should have a label', (WidgetTester tester) async {
      await tester.pumpWidget(
        Directionality(
          child: BlockButton(
            label: 'Label',
            onTap: () {},
          ),
          textDirection: TextDirection.ltr,
        ),
      );

      expect(find.text('Label'), findsOneWidget);
    });
    testWidgets(
      'Should have an onTap function',
      (WidgetTester tester) async {
        int timesCalled = 0;
        final onTap = () => timesCalled += 1;

        await tester.pumpWidget(
          Directionality(
            child: BlockButton(
              label: 'Label',
              onTap: onTap,
            ),
            textDirection: TextDirection.ltr,
          ),
        );

        await tester.tap(find.byType(InkWell));

        expect(timesCalled, 1);
      },
    );
    testWidgets(
      'Can receive an icon',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          Directionality(
            child: BlockButton(
              label: 'Label',
              onTap: () {},
              icon: Icons.add,
            ),
            textDirection: TextDirection.ltr,
          ),
        );

        expect(find.byIcon(Icons.add), findsOneWidget);
      },
    );

    testWidgets(
      'Can receive an icon position',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          Directionality(
            child: BlockButton(
              label: 'Label',
              onTap: () {},
              icon: Icons.add,
              iconPosition: IconPosition.suffix,
            ),
            textDirection: TextDirection.ltr,
          ),
        );

        expect(
          tester.widget(find.byType(Row)),
          isA<Row>().having(
            (r) => r.textDirection,
            'textDirection',
            TextDirection.rtl,
          ),
        );
      },
    );
  });
}
