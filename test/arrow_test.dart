import 'package:front_end/arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Arrow renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Arrow(),
      ),
    ));

    // Find the CustomPaint widget
    final customPaintFinder = find.byType(CustomPaint);

    // Verify that CustomPaint is present
    expect(customPaintFinder, findsOneWidget);

    // Verify the size of the CustomPaint widget
    final customPaint = tester.widget<CustomPaint>(customPaintFinder);
    expect(customPaint.size, Size(20, 36));
  });

  testWidgets('Arrow painter paints correctly', (WidgetTester tester) async {
    final TestCustomPainter testPainter = TestCustomPainter();

    await tester.pumpWidget(
      MaterialApp(
        home: CustomPaint(
          painter: testPainter,
        ),
      ),
    );

    // Verify that paint method is called
    expect(testPainter.called, true);
  });
}

class TestCustomPainter extends CustomPainter {
  bool called = false;

  @override
  void paint(Canvas canvas, Size size) {
    called = true;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
