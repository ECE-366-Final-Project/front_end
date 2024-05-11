import 'package:front_end/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('redGreenFont', () {
    testWidgets('Text color is green for type Win',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: redGreenFont("Win", "Charge"),
        ),
      ));
      final textWidget = find.text('Charge');
      expect(textWidget, findsOneWidget);
      final textStyle = tester.widget<Text>(textWidget).style;
      expect(textStyle!.color, equals(Colors.green));
    });

    testWidgets('Text color is red for type Loss', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: redGreenFont("Loss", "Charge"),
        ),
      ));
      final textWidget = find.text('Charge');
      expect(textWidget, findsOneWidget);
      final textStyle = tester.widget<Text>(textWidget).style;
      expect(textStyle!.color, equals(Colors.red));
    });

    testWidgets('Text color is default for other types',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: redGreenFont("SomeType", "Charge"),
        ),
      ));
      final textWidget = find.text('Charge');
      expect(textWidget, findsOneWidget);
      final textStyle = tester.widget<Text>(textWidget).style;
      expect(textStyle!.color, isNot(equals(Colors.green)));
      expect(textStyle.color, isNot(equals(Colors.red)));
    });
  });

  group('accountItems', () {
    testWidgets('Account item widget has correct item text',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: accountItems("Test Item", "Charge", "Type"),
        ),
      ));
      final itemTextFinder = find.text('Test Item');
      expect(itemTextFinder, findsOneWidget);
    });

    testWidgets('Account item widget has correct charge text',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: accountItems("Test Item", "Charge", "Type"),
        ),
      ));
      final chargeTextFinder = find.text('Charge');
      expect(chargeTextFinder, findsOneWidget);
    });

    testWidgets('Account item widget has correct type text',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: accountItems("Test Item", "Charge", "Type"),
        ),
      ));
      final typeTextFinder = find.text('Type');
      expect(typeTextFinder, findsOneWidget);
    });
  });
}
