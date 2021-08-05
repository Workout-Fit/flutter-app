import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout/widgets/error_snackbar.dart';

void main() {
  group('Error SnackBar', () {
    testWidgets('Background should be red', (WidgetTester tester) async {
      const String snackBarText = 'SnackBar';
      const Key tapTarget = Key('tap-target');

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(builder: (BuildContext context) {
            return GestureDetector(
              key: tapTarget,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  errorSnackBar(snackBarText),
                );
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 100.0,
                width: 100.0,
              ),
            );
          }),
        ),
      ));

      expect(find.text(snackBarText), findsNothing);
      await tester.tap(find.byKey(tapTarget));
      expect(find.text(snackBarText), findsNothing);
      await tester.pump();
      final RenderPhysicalModel renderModel = tester.renderObject(
        find.widgetWithText(Material, snackBarText).first,
      );
      expect(renderModel.color, equals(Colors.red));
    });
  });
}
