import 'package:front_end/roulette.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('smoke test roulette', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(RouletteClass());
  });
}