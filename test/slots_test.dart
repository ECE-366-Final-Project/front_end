import 'package:front_end/slots.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('smoke test slots', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Slots());
  });
}