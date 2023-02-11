import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/poker_bloc.dart';
import 'card.dart';

class WidgetDeck extends StatefulWidget {
  const WidgetDeck({super.key});

  @override
  State<WidgetDeck> createState() => _WidgetDeckState();
}

class _WidgetDeckState extends State<WidgetDeck> {
  @override
  Widget build(BuildContext context) {
    // Put bloc builder for future use
    // such as displaying card stack based on remaining cards
    return BlocBuilder<PokerBloc, PokerState>(
      builder: (context, state) => const WidgetCard(),
    );
  }
}
