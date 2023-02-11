import 'package:flutter/material.dart';

enum CardSuit {
  spades,
  hearts,
  clubs,
  diamonds,
}

class CardFace {
  static const List<String> values = [
    'Ace',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    'Jack',
    'Queen',
    'King',
  ];

  static int strToInt(String face) {
    if (face == 'Ace') return 1;
    if (face == 'King') return 13;
    if (face == 'Queen') return 12;
    if (face == 'Jack') return 11;
    return int.parse(face);
  }

  static String intToStr(int face) => values[face - 1];
}

class PokerCard {
  final CardSuit suit;
  final String face;

  const PokerCard({
    required this.suit,
    required this.face,
  });

  Color get color {
    switch (suit) {
      case CardSuit.spades:
      case CardSuit.clubs:
        return Colors.black;
      case CardSuit.diamonds:
      case CardSuit.hearts:
        return Colors.redAccent;
      default:
        return Colors.transparent;
    }
  }

  static String suitToString(CardSuit suit) {
    switch (suit) {
      case CardSuit.spades:
        return '♠';
      case CardSuit.hearts:
        return '♥';
      case CardSuit.clubs:
        return '♣';
      case CardSuit.diamonds:
        return '♦';
      default:
        return '?';
    }
  }

  static String faceToString(String face) =>
      face == '10' ? '10' : face.substring(0, 1);

  @override
  String toString() {
    final String f = faceToString(face);
    final String s = suitToString(suit);
    return '$f$s';
  }
}
