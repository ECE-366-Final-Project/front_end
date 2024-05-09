import 'package:front_end/arrow.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('smoke test Arrow Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Arrow());
  });
}