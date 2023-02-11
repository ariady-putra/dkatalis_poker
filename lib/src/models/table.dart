import 'card.dart';
import 'deck.dart';
import 'player.dart';

class PokerTable {
  PokerDeck deck = PokerDeck();
  List<PokerCard> discardPile = [];
  List<PokerPlayer> players = [];
  int round = 1;

  PokerTable() {
    deck.cards.shuffle();
    players.addAll([
      PokerPlayer(name: 'You'),
      PokerPlayer(name: 'Player 2'),
      PokerPlayer(name: 'Player 3'),
      PokerPlayer(name: 'Player 4'),
    ]);

    // Always show Your hand
    players[0].hand.showHand();
  }

  nextRound() => round += 1;
}
