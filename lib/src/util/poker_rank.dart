import '../models/card.dart';

/* Ranks 5 set of cards:
    9 - Royal Flush
    8 - Straight Flush
    7 - Four of a Kind
    6 - Full House
    5 - Flush
    4 - Straight
    3 - Three of a Kind
    2 - Two Pairs
    1 - One Pair
    0 - Nothing
*/
class PokerRank {
  final List<PokerCard> cards;

  PokerRank({required this.cards});

  CardSuit? suit;
  int? value;

  int rank() {
    if (isRoyalFlush()) return 9;
    if (isStraightFlush()) return 8;
    if (isFourOfaKind()) return 7;
    if (isFullHouse()) return 6;
    if (isFlush()) return 5;
    if (isStraight()) return 4;
    if (isThreeOfaKind()) return 3;
    if (isTwoPairs()) return 2;
    if (isOnePair()) return 1;

    // Cards already sorted at this point
    suit = cards.first.face == 'Ace' ? cards.first.suit : cards.last.suit;
    value = cards.first.face == 'Ace' ? 14 : CardFace.strToInt(cards.last.face);
    return 0;
  }

  @override
  String toString() {
    switch (rank()) {
      case 9:
        return 'Royal Flush';
      case 8:
        return 'Straight Flush';
      case 7:
        return 'Four of a Kind';
      case 6:
        return 'Full House';
      case 5:
        return 'Flush';
      case 4:
        return 'Straight';
      case 3:
        return 'Three of a Kind';
      case 2:
        return 'Two Pairs';
      case 1:
        return 'One Pair';
      default:
        return PokerCard(
          suit: suit!,
          face: value == 14 ? 'Ace' : CardFace.intToStr(value!),
        ).toString();
    }
  }

  void _sort() => cards.sort(
        (a, b) {
          final faceA = CardFace.strToInt(a.face);
          final faceB = CardFace.strToInt(b.face);
          return faceA.compareTo(faceB);
        },
      );

  CardSuit _getHighestSuit(List<PokerCard> cards) {
    if (cards.indexWhere(
          (card) => card.suit == CardSuit.spades,
        ) >
        -1) {
      return CardSuit.spades;
    }

    if (cards.indexWhere(
          (card) => card.suit == CardSuit.hearts,
        ) >
        -1) {
      return CardSuit.hearts;
    }

    if (cards.indexWhere(
          (card) => card.suit == CardSuit.clubs,
        ) >
        -1) {
      return CardSuit.clubs;
    }

    return CardSuit.diamonds;
  }

  int suitToInt() {
    switch (suit) {
      case CardSuit.spades:
        return 4;
      case CardSuit.hearts:
        return 3;
      case CardSuit.clubs:
        return 2;
      case CardSuit.diamonds:
        return 1;
      default:
        return 0;
    }
  }

  bool isRoyalFlush() {
    suit = cards.first.suit;

    // Ace
    final ace = cards.indexWhere(
      (card) => card.suit == suit && card.face.startsWith('A'),
    );
    if (ace == -1) return false;

    // King
    final king = cards.indexWhere(
      (card) => card.suit == suit && card.face.startsWith('K'),
    );
    if (king == -1) return false;

    // Queen
    final queen = cards.indexWhere(
      (card) => card.suit == suit && card.face.startsWith('Q'),
    );
    if (queen == -1) return false;

    // Jack
    final jack = cards.indexWhere(
      (card) => card.suit == suit && card.face.startsWith('J'),
    );
    if (jack == -1) return false;

    // 10
    final ten = cards.indexWhere(
      (card) => card.suit == suit && card.face == '10',
    );
    if (ten == -1) return false;

    value = 14;
    return true;
  }

  bool isStraightFlush() {
    _sort();

    suit = cards.first.suit;
    int start = CardFace.strToInt(cards.first.face);
    for (PokerCard card in cards) {
      if (card.suit != suit || CardFace.strToInt(card.face) != start++) {
        return false;
      }
    }

    value = start - 1;
    return true;
  }

  bool isFourOfaKind() {
    for (String face in CardFace.values) {
      if (cards
              .where(
                (card) => card.face == face,
              )
              .length ==
          4) {
        suit = CardSuit.spades;
        value = CardFace.strToInt(face);
        return true;
      }
    }
    return false;
  }

  bool isFullHouse() {
    // Find 3 of a kind
    bool has3 = false;
    String? face3;
    for (String face in CardFace.values) {
      final three = cards
          .where(
            (card) => card.face == face,
          )
          .toList();
      if (three.length == 3) {
        has3 = true;
        face3 = face;

        // Find highest suit from the 3
        suit = _getHighestSuit(three);
        // Set rank value
        value = face == 'Ace' ? 14 : CardFace.strToInt(face);
        break;
      }
    }

    // Find the pair
    if (has3) {
      for (String face in CardFace.values) {
        if (face == face3) continue; // skip
        if (cards
                .where(
                  (card) => card.face == face,
                )
                .length ==
            2) {
          return true;
        }
      }
    }

    return false;
  }

  bool isFlush() {
    _sort();

    suit = cards.first.suit;

    value = cards.first.face == 'Ace' ? 14 : CardFace.strToInt(cards.last.face);

    return cards
            .where(
              (card) => card.suit == suit,
            )
            .length ==
        5;
  }

  bool isStraight() {
    _sort();

    // Low Ace Straight
    if (cards[0].face == 'Ace' &&
        cards[1].face == '2' &&
        cards[2].face == '3' &&
        cards[3].face == '4' &&
        cards[4].face == '5') {
      suit = cards[4].suit;
      value = 5;
      return true;
    }

    // High Ace Straight
    if (cards[0].face == 'Ace' &&
        cards[1].face == '10' &&
        cards[2].face == 'Jack' &&
        cards[3].face == 'Queen' &&
        cards[4].face == 'King') {
      suit = cards[0].suit;
      value = 14;
      return true;
    }

    // Other Straight ?
    int start = CardFace.strToInt(cards.first.face);
    for (PokerCard card in cards) {
      if (CardFace.strToInt(card.face) != start++) {
        return false;
      }
    }
    suit = cards.last.suit;
    value = start - 1;
    return true;
  }

  bool isThreeOfaKind() {
    for (String face in CardFace.values) {
      final three = cards
          .where(
            (card) => card.face == face,
          )
          .toList();
      if (three.length == 3) {
        // Find highest suit from the 3
        suit = _getHighestSuit(three);
        // Set rank value
        value = face == 'Ace' ? 14 : CardFace.strToInt(face);
        return true;
      }
    }
    return false;
  }

  bool isTwoPairs() {
    _sort();

    // First pair
    bool has2 = false;
    String? face2;
    for (String face in CardFace.values) {
      if (cards
              .where(
                (card) => card.face == face,
              )
              .length ==
          2) {
        has2 = true;
        face2 = face;
        break;
      }
    }

    // Second pair
    if (has2) {
      for (String face in CardFace.values) {
        if (face == face2) continue; // skip

        final pair = cards
            .where(
              (card) => card.face == face,
            )
            .toList();
        if (pair.length == 2) {
          // Find highest suit from the pair
          suit = _getHighestSuit(pair);
          // Set rank value
          value = face == 'Ace' ? 14 : CardFace.strToInt(face);
          return true;
        }
      }
    }
    return false;
  }

  bool isOnePair() {
    for (String face in CardFace.values) {
      final pair = cards
          .where(
            (card) => card.face == face,
          )
          .toList();
      if (pair.length == 2) {
        // Find highest suit from the pair
        suit = _getHighestSuit(pair);
        // Set rank value
        value = face == 'Ace' ? 14 : CardFace.strToInt(face);
        return true;
      }
    }
    return false;
  }
}
