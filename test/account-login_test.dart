import 'package:front_end/account-login.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('smoke test Account Login Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(AccountLogin());
  });
}