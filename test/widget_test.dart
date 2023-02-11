import 'package:dkatalis_poker/src/bloc/poker_bloc.dart';
import 'package:dkatalis_poker/src/widgets/table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Deal cards test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => PokerBloc(),
          child: const WidgetTable(),
        ),
      ),
    );

    // Verify that the deal button exists
    expect(find.text('Deal'), findsOneWidget);

    // Tap the deal button
    await tester.tap(
      find.byKey(
        const Key('dealButton'),
      ),
    );
    await tester.pump();

    // Verify that cards are distributed
    expect(
      find.byKey(
        const Key('playingCard'),
      ),
      findsNWidgets(21), // 5 x 4player + 1deck
    );
  });
}
