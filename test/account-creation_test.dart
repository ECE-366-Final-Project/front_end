import 'package:front_end/account-creation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('smoke test Account Creation Widget',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(AccountCreation());
  });
}
