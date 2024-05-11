import 'package:front_end/home.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('smoke test home', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Home());
  });
}