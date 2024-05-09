import 'package:front_end/depo-withdraw.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('smoke test depo withdraw', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(DepoWithdraw());
  });
}