import 'package:flutter/material.dart';
import 'package:front_end/roulette.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:front_end/roulette_generators.dart';

void main() {
  group('RouletteClass Widget Tests', () {
    testWidgets('RouletteClass Widget Builds Correctly',
        (WidgetTester tester) async {
      // Test whether the RouletteClass widget builds without throwing any errors
      await tester.pumpWidget(RouletteClass());

      // Verify that the widget renders correctly
      expect(find.byType(RouletteClass), findsOneWidget);
      // Add more verification if needed
    });

    testWidgets('Tapping Clear Button Resets Bets',
        (WidgetTester tester) async {
      // Test whether tapping the Clear button resets the bets
      await tester.pumpWidget(RouletteClass());

      // Tap the Clear button
      await tester.tap(find.widgetWithText(TextButton, 'Clear'));
      await tester.pump();

      // Verify that the bets are reset to default values
      // For example, you can check if rouletteBet is reset to "1"
      expect(rouletteBet, "1");
      // Add more verification if needed
    });

    // Add more test cases for other functionalities, such as tapping Play Singleplayer,
    // checking balance updates, etc.
  });
}
