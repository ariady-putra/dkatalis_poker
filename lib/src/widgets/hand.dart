import 'package:flutter/material.dart';

import '../models/hand.dart';
import 'card.dart';

class WidgetHand extends StatefulWidget {
  const WidgetHand({
    required this.hand,
    this.cardSizeScale = 1,
    super.key,
  });

  final PokerHand hand;
  final double cardSizeScale;

  @override
  State<WidgetHand> createState() => _WidgetHandState();
}

class _WidgetHandState extends State<WidgetHand> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widget.hand.cards
          .map(
            (card) => WidgetCard(
              card: card,
              faceUp: widget.hand.shown,
              cardSizeScale: widget.cardSizeScale,
            ),
          )
          .toList(),
    );
  }
}
