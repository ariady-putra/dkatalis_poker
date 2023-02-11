import 'package:flutter/material.dart';

import '../models/card.dart';

class WidgetCard extends StatefulWidget {
  const WidgetCard({
    this.card,
    this.cardSizeScale = 1,
    this.faceUp = false,
    super.key,
  });

  final PokerCard? card;
  final double cardSizeScale;
  final bool faceUp;

  double getWidth() => cardSizeScale * 125;
  double getHeight() => cardSizeScale * 175;

  @override
  State<WidgetCard> createState() => _WidgetCardState();
}

class _WidgetCardState extends State<WidgetCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.faceUp ? Colors.white : Colors.blue,
      elevation: 4,
      child: SizedBox(
        width: widget.getWidth(),
        height: widget.getHeight(),
        child: !widget.faceUp || widget.card == null
            ? null
            : Center(
                child: Text(
                  '${widget.card}',
                  style: TextStyle(
                    fontSize: widget.cardSizeScale * 50,
                    color: widget.card!.color,
                  ),
                ),
              ),
      ),
    );
  }
}
