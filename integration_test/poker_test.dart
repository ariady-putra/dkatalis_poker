import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:dkatalis_poker/src/poker_app.dart';

const Duration sec = Duration(seconds: 1);

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    "Poker App Integration Tests",
    (WidgetTester tester) async {
      runApp(
        const PokerApp(),
      );
      await tester.pumpAndSettle(sec);

      await _dealCardsTest(tester);
      await _revealCardsTest(tester);
      await _nextRoundTest(tester);
    },
  );
}

_dealCardsTest(WidgetTester tester) async {
  // Arrange
  final Finder dealButton = find.byKey(
    const Key('dealButton'),
  );

  // Action
  await tester.tap(dealButton);
  // https://medium.com/swlh/3-tricks-to-test-your-widgets-with-flutter-more-comfortably-88fcae5616cc
  await tester.pump(sec);

  // Assert
  expect(
    find.textContaining('Cards have been distributed, reveal cards now'),
    findsOneWidget,
  );
  expect(
    find.text('Next'), // Next button
    findsOneWidget,
  );
}

_revealCardsTest(WidgetTester tester) async {
  // Arrange
  final Finder nextButton = find.byKey(
    const Key('cardsDealtNextButton'),
  );

  // Action
  await tester.tap(nextButton);
  await tester.pump(sec);

  // Assert
  expect(
    find.textContaining('win'),
    findsOneWidget,
  );
  expect(
    find.text('Next'), // Next button
    findsOneWidget,
  );
}

_nextRoundTest(WidgetTester tester) async {
  // Arrange
  final Finder nextButton = find.byKey(
    const Key('cardsRevealedNextButton'),
  );

  // Action
  await tester.tap(nextButton);
  await tester.pump(sec);

  // Assert
  expect(
    find.text('Deal'), // Deal button
    findsOneWidget,
  );
}
