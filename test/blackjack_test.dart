import 'package:front_end/blackjack.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('smoke test Blackjack', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Blackjack());
  });

//clearDeck();
//expect(dealerCards, []);
//expect(playerCards, []);
//expect(renderDealCards, []);
//expect(renderPlayerCards, []);
//expect(playerString, []);
//expect(dealerString, []);
}
