import 'card.dart';

class PokerHand {
  List<PokerCard> cards = [];
  bool shown = false;

  dealCard(PokerCard card) => cards.add(card);
  clearCards() => cards.clear();
  showHand() => shown = true;
  hideHand() => shown = false;
}
