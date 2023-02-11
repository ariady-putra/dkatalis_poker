import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/poker_bloc.dart';
import 'hand.dart';

class WidgetPlayer extends StatefulWidget {
  const WidgetPlayer({
    required this.playerIndex,
    this.cardSizeScale = 1,
    super.key,
  });

  final int playerIndex;
  final double cardSizeScale;

  @override
  State<WidgetPlayer> createState() => _WidgetPlayerState();
}

class _WidgetPlayerState extends State<WidgetPlayer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokerBloc, PokerState>(
      builder: (context, state) => WidgetHand(
        hand: state.table.players[widget.playerIndex].hand,
        cardSizeScale: widget.cardSizeScale,
      ),
    );
  }
}
