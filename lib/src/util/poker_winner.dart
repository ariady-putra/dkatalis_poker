import '../models/player.dart';
import 'poker_rank.dart';

class PokerWinner {
  final List<PokerPlayer> players;

  const PokerWinner({required this.players});

  PokerPlayer getWinner() {
    List<PokerPlayer> copy = List.from(players);
    copy.sort(
      (a, b) {
        PokerRank aPokerRank = PokerRank(cards: a.hand.cards);
        PokerRank bPokerRank = PokerRank(cards: b.hand.cards);

        final int aRank = aPokerRank.rank();
        final int bRank = bPokerRank.rank();

        int score = bRank - aRank;
        if (score != 0) return score;

        switch (aRank) {
          // Royal Flush
          case 9:
            // If there are multiple Royal Flushes in a game,
            // the hand with the highest suit wins.
            score = bPokerRank.suitToInt() - aPokerRank.suitToInt();
            return score;

          // Straight Flush
          case 8:
            // If there are multiple Straight Flushes in a game,
            // the hand with the highest suit wins.
            score = bPokerRank.suitToInt() - aPokerRank.suitToInt();
            if (score != 0) return score;

            // If they are the same suit,
            // the highest rank wins.
            score = bPokerRank.value! - aPokerRank.value!;
            return score;

          // Four of a Kind
          case 7:
            // If there are multiple Four of a Kind in a game,
            // the hand with the highest rank wins.
            score = bPokerRank.value! - aPokerRank.value!;
            return score;

          // Full House
          case 6:
            // If there are multiple Full Houses in a game,
            // the hand with the highest rank of the 3 cards wins.
            score = bPokerRank.value! - aPokerRank.value!;
            return score;

          // Flush
          case 5:
            // If there are multiple Flushes in a game,
            // the hand with the highest suit wins.
            score = bPokerRank.suitToInt() - aPokerRank.suitToInt();
            if (score != 0) return score;

            // If they are the same suit,
            // the highest rank wins.
            score = bPokerRank.value! - aPokerRank.value!;
            return score;

          // Straight
          case 4:
            // If there are multiple straights in a game,
            // the hand with the highest rank wins.
            score = bPokerRank.value! - aPokerRank.value!;
            if (score != 0) return score;

            // If they are the same rank,
            // the highest suit wins.
            score = bPokerRank.suitToInt() - aPokerRank.suitToInt();
            return score;

          // Three of a Kind
          case 3:
            // If there are multiple Three of a Kinds in a game,
            // the hand with the highest rank wins.
            score = bPokerRank.value! - aPokerRank.value!;
            return score;

          // Two Pairs
          case 2:
            // If there are multiple Two Pairs in a game,
            // the hand with the highest rank wins.
            score = bPokerRank.value! - aPokerRank.value!;
            if (score != 0) return score;

            // If they are the same rank,
            // the highest suit wins.
            score = bPokerRank.suitToInt() - aPokerRank.suitToInt();
            return score;

          // One Pair
          case 1:
            // If there are multiple One Pairs in a game,
            // the hand with the highest rank wins.
            score = bPokerRank.value! - aPokerRank.value!;
            if (score != 0) return score;

            // If they are the same rank,
            // the highest suit wins.
            score = bPokerRank.suitToInt() - aPokerRank.suitToInt();
            return score;

          // Nothing
          default:
            // If there are multiple Nothings in a game,
            // the hand with the highest rank wins.
            score = bPokerRank.value! - aPokerRank.value!;
            if (score != 0) return score;

            // If they are the same rank,
            // the highest suit wins.
            score = bPokerRank.suitToInt() - aPokerRank.suitToInt();
            return score;
        }
      },
    );
    return copy.first;
  }
}
