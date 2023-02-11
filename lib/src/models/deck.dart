import 'card.dart';

class PokerDeck {
  final List<PokerCard> cards = [];

  PokerDeck() {
    newDeck();
  }

  int deckCount = 0;

  void newDeck() {
    cards.clear();
    for (CardSuit suit in CardSuit.values) {
      for (String face in CardFace.values) {
        cards.add(
          PokerCard(
            suit: suit,
            face: face,
          ),
        );
      }
    }
    deckCount++;
  }
}
