import 'package:dkatalis_poker/src/models/card.dart';
import 'package:dkatalis_poker/src/models/deck.dart';
import 'package:dkatalis_poker/src/models/hand.dart';
import 'package:dkatalis_poker/src/models/player.dart';
import 'package:dkatalis_poker/src/models/table.dart';
import 'package:dkatalis_poker/src/util/poker_rank.dart';
import 'package:dkatalis_poker/src/util/poker_winner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Card
  const PokerCard card = PokerCard(
    suit: CardSuit.spades,
    face: 'Ace',
  );
  group('Card Tests', () {
    test('Card label should be A♠', () {
      expect(card.toString(), 'A♠');
    });
    test('Card color should be black', () {
      expect(card.color, Colors.black);
    });

    test('Card int should be 1', () {
      expect(CardFace.strToInt(card.face), 1);
    });
    test('Card str should be King', () {
      expect(CardFace.intToStr(13), 'King');
    });

    test('Cards should be Royal Flush', () {
      expect(
          PokerRank(cards: [
            const PokerCard(suit: CardSuit.clubs, face: 'Ace'),
            const PokerCard(suit: CardSuit.clubs, face: 'Queen'),
            const PokerCard(suit: CardSuit.clubs, face: '10'),
            const PokerCard(suit: CardSuit.clubs, face: 'Jack'),
            const PokerCard(suit: CardSuit.clubs, face: 'King'),
          ]).isRoyalFlush(),
          true);
    });
    test('Cards should be Straight Flush', () {
      // Arrange
      final hand = [
        const PokerCard(suit: CardSuit.diamonds, face: 'Ace'),
        const PokerCard(suit: CardSuit.diamonds, face: '3'),
        const PokerCard(suit: CardSuit.diamonds, face: '5'),
        const PokerCard(suit: CardSuit.diamonds, face: '4'),
        const PokerCard(suit: CardSuit.diamonds, face: '2'),
      ];

      // Action
      final rank = PokerRank(cards: hand);
      final isStraightFlush = rank.isStraightFlush();
      final rankSuit = rank.suit;
      final rankValue = rank.value;

      // Assert
      expect(isStraightFlush, true);
      expect(rankSuit, CardSuit.diamonds);
      expect(rankValue, 5);
    });
    test('Cards should be Four of a Kind', () {
      // Arrange
      final hand = [
        const PokerCard(suit: CardSuit.hearts, face: 'Ace'),
        const PokerCard(suit: CardSuit.spades, face: '5'),
        const PokerCard(suit: CardSuit.hearts, face: '5'),
        const PokerCard(suit: CardSuit.diamonds, face: '5'),
        const PokerCard(suit: CardSuit.clubs, face: '5'),
      ];

      // Action
      final rank = PokerRank(cards: hand);
      final isCorrect = rank.isFourOfaKind();
      final rankSuit = rank.suit;
      final rankValue = rank.value;

      // Assert
      expect(isCorrect, true);
      expect(rankSuit, CardSuit.spades);
      expect(rankValue, 5);
    });
    test('Cards should be Full House', () {
      // Arrange
      final hand = [
        const PokerCard(suit: CardSuit.diamonds, face: 'Ace'),
        const PokerCard(suit: CardSuit.hearts, face: 'Ace'),
        const PokerCard(suit: CardSuit.clubs, face: 'Ace'),
        const PokerCard(suit: CardSuit.clubs, face: '5'),
        const PokerCard(suit: CardSuit.diamonds, face: '5'),
      ];

      // Action
      final rank = PokerRank(cards: hand);
      final isCorrect = rank.isFullHouse();
      final rankSuit = rank.suit;
      final rankValue = rank.value;

      // Assert
      expect(isCorrect, true);
      expect(rankSuit, CardSuit.hearts);
      expect(rankValue, 14);
    });
    test('Cards should be Flush', () {
      // Arrange
      final hand = [
        const PokerCard(suit: CardSuit.clubs, face: '6'),
        const PokerCard(suit: CardSuit.clubs, face: '8'),
        const PokerCard(suit: CardSuit.clubs, face: 'Ace'),
        const PokerCard(suit: CardSuit.clubs, face: '7'),
        const PokerCard(suit: CardSuit.clubs, face: '5'),
      ];

      // Action
      final rank = PokerRank(cards: hand);
      final isCorrect = rank.isFlush();
      final rankSuit = rank.suit;
      final rankValue = rank.value;

      // Assert
      expect(isCorrect, true);
      expect(rankSuit, CardSuit.clubs);
      expect(rankValue, 14);
    });

    test('Cards should be Low Ace Straight', () {
      // Arrange
      final hand = [
        const PokerCard(suit: CardSuit.diamonds, face: '3'),
        const PokerCard(suit: CardSuit.hearts, face: '5'),
        const PokerCard(suit: CardSuit.spades, face: 'Ace'),
        const PokerCard(suit: CardSuit.hearts, face: '4'),
        const PokerCard(suit: CardSuit.diamonds, face: '2'),
      ];

      // Action
      final rank = PokerRank(cards: hand);
      final isCorrect = rank.isStraight();
      final rankSuit = rank.suit;
      final rankValue = rank.value;

      // Assert
      expect(isCorrect, true);
      expect(rankSuit, CardSuit.hearts);
      expect(rankValue, 5);
    });
    test('Cards should be High Ace Straight', () {
      // Arrange
      final hand = [
        const PokerCard(suit: CardSuit.hearts, face: 'Jack'),
        const PokerCard(suit: CardSuit.spades, face: 'King'),
        const PokerCard(suit: CardSuit.hearts, face: 'Ace'),
        const PokerCard(suit: CardSuit.diamonds, face: 'Queen'),
        const PokerCard(suit: CardSuit.clubs, face: '10'),
      ];

      // Action
      final rank = PokerRank(cards: hand);
      final isCorrect = rank.isStraight();
      final rankSuit = rank.suit;
      final rankValue = rank.value;

      // Assert
      expect(isCorrect, true);
      expect(rankSuit, CardSuit.hearts);
      expect(rankValue, 14);
    });
    test('Cards should be Straight', () {
      // Arrange
      final hand = [
        const PokerCard(suit: CardSuit.clubs, face: '7'),
        const PokerCard(suit: CardSuit.diamonds, face: '9'),
        const PokerCard(suit: CardSuit.hearts, face: '10'),
        const PokerCard(suit: CardSuit.spades, face: '8'),
        const PokerCard(suit: CardSuit.hearts, face: '6'),
      ];

      // Action
      final rank = PokerRank(cards: hand);
      final isCorrect = rank.isStraight();
      final rankSuit = rank.suit;
      final rankValue = rank.value;

      // Assert
      expect(isCorrect, true);
      expect(rankSuit, CardSuit.hearts);
      expect(rankValue, 10);
    });

    test('Cards should be Three of a Kind', () {
      // Arrange
      final hand = [
        const PokerCard(suit: CardSuit.diamonds, face: '7'),
        const PokerCard(suit: CardSuit.hearts, face: '9'),
        const PokerCard(suit: CardSuit.spades, face: '10'),
        const PokerCard(suit: CardSuit.clubs, face: '9'),
        const PokerCard(suit: CardSuit.diamonds, face: '9'),
      ];

      // Action
      final rank = PokerRank(cards: hand);
      final isCorrect = rank.isThreeOfaKind();
      final rankSuit = rank.suit;
      final rankValue = rank.value;

      // Assert
      expect(isCorrect, true);
      expect(rankSuit, CardSuit.hearts);
      expect(rankValue, 9);
    });
    test('Cards should be Two Pairs', () {
      // Arrange
      final hand = [
        const PokerCard(suit: CardSuit.diamonds, face: '7'),
        const PokerCard(suit: CardSuit.hearts, face: '9'),
        const PokerCard(suit: CardSuit.spades, face: '10'),
        const PokerCard(suit: CardSuit.clubs, face: '7'),
        const PokerCard(suit: CardSuit.diamonds, face: '9'),
      ];

      // Action
      final rank = PokerRank(cards: hand);
      final isCorrect = rank.isTwoPairs();
      final rankSuit = rank.suit;
      final rankValue = rank.value;

      // Assert
      expect(isCorrect, true);
      expect(rankSuit, CardSuit.hearts);
      expect(rankValue, 9);
    });
    test('Cards should be One Pair', () {
      // Arrange
      final hand = [
        const PokerCard(suit: CardSuit.diamonds, face: '7'),
        const PokerCard(suit: CardSuit.hearts, face: '8'),
        const PokerCard(suit: CardSuit.spades, face: '10'),
        const PokerCard(suit: CardSuit.clubs, face: '7'),
        const PokerCard(suit: CardSuit.diamonds, face: '9'),
      ];

      // Action
      final rank = PokerRank(cards: hand);
      final isCorrect = rank.isOnePair();
      final rankSuit = rank.suit;
      final rankValue = rank.value;

      // Assert
      expect(isCorrect, true);
      expect(rankSuit, CardSuit.clubs);
      expect(rankValue, 7);
    });

    test('Cards rank should be all correct', () {
      // Arrange
      final hands = [];
      final handsSuit = [];
      final handsValue = [];

      hands.add([
        // Royal Flush
        const PokerCard(suit: CardSuit.clubs, face: 'King'),
        const PokerCard(suit: CardSuit.clubs, face: 'Jack'),
        const PokerCard(suit: CardSuit.clubs, face: '10'),
        const PokerCard(suit: CardSuit.clubs, face: 'Queen'),
        const PokerCard(suit: CardSuit.clubs, face: 'Ace'),
      ]);
      handsSuit.add(CardSuit.clubs);
      handsValue.add(14);

      hands.add([
        // Straight Flush
        const PokerCard(suit: CardSuit.diamonds, face: 'King'),
        const PokerCard(suit: CardSuit.diamonds, face: 'Jack'),
        const PokerCard(suit: CardSuit.diamonds, face: '10'),
        const PokerCard(suit: CardSuit.diamonds, face: 'Queen'),
        const PokerCard(suit: CardSuit.diamonds, face: '9'),
      ]);
      handsSuit.add(CardSuit.diamonds);
      handsValue.add(13);

      hands.add([
        // Four of a Kind
        const PokerCard(suit: CardSuit.hearts, face: 'King'),
        const PokerCard(suit: CardSuit.spades, face: '8'),
        const PokerCard(suit: CardSuit.hearts, face: '8'),
        const PokerCard(suit: CardSuit.diamonds, face: '8'),
        const PokerCard(suit: CardSuit.clubs, face: '8'),
      ]);
      handsSuit.add(CardSuit.spades);
      handsValue.add(8);

      hands.add([
        // Full House
        const PokerCard(suit: CardSuit.diamonds, face: 'Jack'),
        const PokerCard(suit: CardSuit.hearts, face: 'Jack'),
        const PokerCard(suit: CardSuit.spades, face: '10'),
        const PokerCard(suit: CardSuit.hearts, face: '10'),
        const PokerCard(suit: CardSuit.diamonds, face: '10'),
      ]);
      handsSuit.add(CardSuit.spades);
      handsValue.add(10);

      hands.add([
        // Flush
        const PokerCard(suit: CardSuit.hearts, face: '6'),
        const PokerCard(suit: CardSuit.hearts, face: 'Jack'),
        const PokerCard(suit: CardSuit.hearts, face: '10'),
        const PokerCard(suit: CardSuit.hearts, face: 'Queen'),
        const PokerCard(suit: CardSuit.hearts, face: '7'),
      ]);
      handsSuit.add(CardSuit.hearts);
      handsValue.add(12);

      hands.add([
        // Straight
        const PokerCard(suit: CardSuit.spades, face: '4'),
        const PokerCard(suit: CardSuit.hearts, face: '2'),
        const PokerCard(suit: CardSuit.diamonds, face: 'Ace'),
        const PokerCard(suit: CardSuit.clubs, face: '3'),
        const PokerCard(suit: CardSuit.diamonds, face: '5'),
      ]);
      handsSuit.add(CardSuit.diamonds);
      handsValue.add(5);

      hands.add([
        // Three of a Kind
        const PokerCard(suit: CardSuit.clubs, face: 'King'),
        const PokerCard(suit: CardSuit.diamonds, face: '2'),
        const PokerCard(suit: CardSuit.hearts, face: '10'),
        const PokerCard(suit: CardSuit.spades, face: '2'),
        const PokerCard(suit: CardSuit.hearts, face: '2'),
      ]);
      handsSuit.add(CardSuit.spades);
      handsValue.add(2);

      hands.add([
        // Two Pairs
        const PokerCard(suit: CardSuit.diamonds, face: '4'),
        const PokerCard(suit: CardSuit.clubs, face: 'Jack'),
        const PokerCard(suit: CardSuit.diamonds, face: '3'),
        const PokerCard(suit: CardSuit.hearts, face: '4'),
        const PokerCard(suit: CardSuit.spades, face: '3'),
      ]);
      handsSuit.add(CardSuit.hearts);
      handsValue.add(4);

      hands.add([
        // One Pair
        const PokerCard(suit: CardSuit.hearts, face: 'King'),
        const PokerCard(suit: CardSuit.diamonds, face: 'Jack'),
        const PokerCard(suit: CardSuit.clubs, face: '10'),
        const PokerCard(suit: CardSuit.diamonds, face: '5'),
        const PokerCard(suit: CardSuit.hearts, face: '5'),
      ]);
      handsSuit.add(CardSuit.hearts);
      handsValue.add(5);

      hands.add([
        // Nothing
        const PokerCard(suit: CardSuit.spades, face: '7'),
        const PokerCard(suit: CardSuit.hearts, face: 'Jack'),
        const PokerCard(suit: CardSuit.diamonds, face: '10'),
        const PokerCard(suit: CardSuit.clubs, face: '8'),
        const PokerCard(suit: CardSuit.diamonds, face: '6'),
      ]);
      handsSuit.add(CardSuit.hearts);
      handsValue.add(11);

      for (int i = 0; i < 10; i++) {
        // Action
        final rank = PokerRank(cards: hands[i]);
        final ranking = rank.rank;
        final rankSuit = rank.suit;
        final rankValue = rank.value;

        // Assert
        expect(ranking, 9 - i);
        expect(rankSuit, handsSuit[i]);
        expect(rankValue, handsValue[i]);
      }
    });
  });

  // Deck
  final PokerDeck deck = PokerDeck();
  group('Deck Tests', () {
    test('Card count should be 52', () {
      expect(deck.cards.length, 52);
    });

    test('The first card of an unshuffled deck should be A♠', () {
      expect(deck.cards.first.toString(), 'A♠');
    });
    test('The last card of an unshuffled deck should be K♦', () {
      expect(deck.cards.last.toString(), 'K♦');
    });
  });

  // Hand
  final PokerHand hand = PokerHand();
  const List<PokerCard> cards = [
    PokerCard(suit: CardSuit.clubs, face: '2'),
    PokerCard(suit: CardSuit.diamonds, face: '10'),
    PokerCard(suit: CardSuit.hearts, face: 'Jack'),
    PokerCard(suit: CardSuit.spades, face: 'Queen'),
    PokerCard(suit: CardSuit.clubs, face: 'King'),
  ];
  group('Hand Tests', () {
    // deal cards
    for (PokerCard card in cards) {
      hand.dealCard(card);
    }
    test('Hand size should be 5', () {
      expect(hand.cards.length, 5);
    });

    // show hand
    hand.showHand();
    test('Hands shown should be true', () {
      expect(hand.shown, true);
    });
  });

  // Player
  final PokerPlayer player = PokerPlayer(name: 'Player 1');
  player.hand = hand;
  player.win();
  group('Player Tests', () {
    test("Player's hand size should be 5", () {
      expect(player.hand.cards.length, 5);
    });

    test("Player's name should be Player 1", () {
      expect(player.name, 'Player 1');
    });

    test("Player's win count should be 1", () {
      expect(player.wins, 1);
    });
  });

  // Table
  final PokerTable table = PokerTable();
  final List<PokerPlayer> players = [player];
  players.addAll(
    [2, 3, 4].map(
      (p) => PokerPlayer(name: 'Player $p'),
    ),
  );
  table.players = players;
  table.nextRound();
  group('Table Tests', () {
    test('Player count should be 4', () {
      expect(table.players.length, 4);
    });

    test('Current table round should be 2', () {
      expect(table.round, 2);
    });
  });

  // Winner
  group('Winner Tests', () {
    test('Player 1 should be winning', () {
      // Arrange
      PokerPlayer player1 = PokerPlayer(name: 'Player 1');
      PokerPlayer player2 = PokerPlayer(name: 'Player 2');

      player1.hand.cards = [
        const PokerCard(suit: CardSuit.clubs, face: 'Ace'),
        const PokerCard(suit: CardSuit.clubs, face: 'King'),
        const PokerCard(suit: CardSuit.clubs, face: 'Queen'),
        const PokerCard(suit: CardSuit.clubs, face: 'Jack'),
        const PokerCard(suit: CardSuit.clubs, face: '10'),
      ];
      player2.hand.cards = [
        const PokerCard(suit: CardSuit.diamonds, face: 'Ace'),
        const PokerCard(suit: CardSuit.diamonds, face: 'King'),
        const PokerCard(suit: CardSuit.diamonds, face: 'Queen'),
        const PokerCard(suit: CardSuit.diamonds, face: 'Jack'),
        const PokerCard(suit: CardSuit.diamonds, face: '10'),
      ];

      // Action
      PokerWinner pokerWinner = PokerWinner(players: [player1, player2]);
      PokerPlayer winner = pokerWinner.getWinner();

      // Assert
      expect(winner.name, 'Player 1');
      expect('${PokerRank(cards: winner.hand.cards)}', 'Royal Flush');
    });

    test('Player 1 should win by Royal Flush', () {
      // Arrange
      PokerPlayer player1 = PokerPlayer(name: 'Player 1');
      PokerPlayer player2 = PokerPlayer(name: 'Player 2');

      player1.hand.cards = [
        const PokerCard(suit: CardSuit.clubs, face: 'Ace'),
        const PokerCard(suit: CardSuit.clubs, face: 'King'),
        const PokerCard(suit: CardSuit.clubs, face: 'Queen'),
        const PokerCard(suit: CardSuit.clubs, face: 'Jack'),
        const PokerCard(suit: CardSuit.clubs, face: '10'),
      ];
      player2.hand.cards = [
        const PokerCard(suit: CardSuit.hearts, face: '9'),
        const PokerCard(suit: CardSuit.hearts, face: 'King'),
        const PokerCard(suit: CardSuit.hearts, face: 'Queen'),
        const PokerCard(suit: CardSuit.hearts, face: 'Jack'),
        const PokerCard(suit: CardSuit.hearts, face: '10'),
      ];

      // Action
      PokerWinner pokerWinner = PokerWinner(players: [player1, player2]);
      PokerPlayer winner = pokerWinner.getWinner();

      // Assert
      expect(winner.name, 'Player 1');
      expect('${PokerRank(cards: winner.hand.cards)}', 'Royal Flush');
    });

    test('Player 1 should win by Straight Flush', () {
      // Arrange
      PokerPlayer player1 = PokerPlayer(name: 'Player 1');
      PokerPlayer player2 = PokerPlayer(name: 'Player 2');

      player1.hand.cards = [
        const PokerCard(suit: CardSuit.clubs, face: '9'),
        const PokerCard(suit: CardSuit.clubs, face: 'King'),
        const PokerCard(suit: CardSuit.clubs, face: 'Queen'),
        const PokerCard(suit: CardSuit.clubs, face: 'Jack'),
        const PokerCard(suit: CardSuit.clubs, face: '10'),
      ];
      player2.hand.cards = [
        const PokerCard(suit: CardSuit.hearts, face: 'King'),
        const PokerCard(suit: CardSuit.diamonds, face: 'King'),
        const PokerCard(suit: CardSuit.spades, face: 'King'),
        const PokerCard(suit: CardSuit.hearts, face: 'Jack'),
        const PokerCard(suit: CardSuit.clubs, face: 'King'),
      ];

      // Action
      PokerWinner pokerWinner = PokerWinner(players: [player1, player2]);
      PokerPlayer winner = pokerWinner.getWinner();

      // Assert
      expect(winner.name, 'Player 1');
      expect('${PokerRank(cards: winner.hand.cards)}', 'Straight Flush');
    });

    test('Player 1 should win by Four of a Kind', () {
      // Arrange
      PokerPlayer player1 = PokerPlayer(name: 'Player 1');
      PokerPlayer player2 = PokerPlayer(name: 'Player 2');

      player1.hand.cards = [
        const PokerCard(suit: CardSuit.hearts, face: 'King'),
        const PokerCard(suit: CardSuit.diamonds, face: 'King'),
        const PokerCard(suit: CardSuit.spades, face: 'King'),
        const PokerCard(suit: CardSuit.hearts, face: 'Jack'),
        const PokerCard(suit: CardSuit.clubs, face: 'King'),
      ];
      player2.hand.cards = [
        const PokerCard(suit: CardSuit.clubs, face: '7'),
        const PokerCard(suit: CardSuit.clubs, face: '8'),
        const PokerCard(suit: CardSuit.diamonds, face: '8'),
        const PokerCard(suit: CardSuit.hearts, face: '8'),
        const PokerCard(suit: CardSuit.diamonds, face: '7'),
      ];

      // Action
      PokerWinner pokerWinner = PokerWinner(players: [player1, player2]);
      PokerPlayer winner = pokerWinner.getWinner();

      // Assert
      expect(winner.name, 'Player 1');
      expect('${PokerRank(cards: winner.hand.cards)}', 'Four of a Kind');
    });

    test('Player 1 should win by Full House', () {
      // Arrange
      PokerPlayer player1 = PokerPlayer(name: 'Player 1');
      PokerPlayer player2 = PokerPlayer(name: 'Player 2');

      player1.hand.cards = [
        const PokerCard(suit: CardSuit.clubs, face: '7'),
        const PokerCard(suit: CardSuit.clubs, face: '8'),
        const PokerCard(suit: CardSuit.diamonds, face: '8'),
        const PokerCard(suit: CardSuit.hearts, face: '8'),
        const PokerCard(suit: CardSuit.diamonds, face: '7'),
      ];
      player2.hand.cards = [
        const PokerCard(suit: CardSuit.spades, face: 'King'),
        const PokerCard(suit: CardSuit.spades, face: 'Jack'),
        const PokerCard(suit: CardSuit.spades, face: '10'),
        const PokerCard(suit: CardSuit.spades, face: '2'),
        const PokerCard(suit: CardSuit.spades, face: 'Ace'),
      ];

      // Action
      PokerWinner pokerWinner = PokerWinner(players: [player1, player2]);
      PokerPlayer winner = pokerWinner.getWinner();

      // Assert
      expect(winner.name, 'Player 1');
      expect('${PokerRank(cards: winner.hand.cards)}', 'Full House');
    });

    test('Player 1 should win by Flush', () {
      // Arrange
      PokerPlayer player1 = PokerPlayer(name: 'Player 1');
      PokerPlayer player2 = PokerPlayer(name: 'Player 2');

      player1.hand.cards = [
        const PokerCard(suit: CardSuit.spades, face: 'King'),
        const PokerCard(suit: CardSuit.spades, face: 'Jack'),
        const PokerCard(suit: CardSuit.spades, face: '10'),
        const PokerCard(suit: CardSuit.spades, face: '2'),
        const PokerCard(suit: CardSuit.spades, face: 'Ace'),
      ];
      player2.hand.cards = [
        const PokerCard(suit: CardSuit.clubs, face: '6'),
        const PokerCard(suit: CardSuit.clubs, face: '4'),
        const PokerCard(suit: CardSuit.diamonds, face: '2'),
        const PokerCard(suit: CardSuit.hearts, face: '3'),
        const PokerCard(suit: CardSuit.diamonds, face: '5'),
      ];

      // Action
      PokerWinner pokerWinner = PokerWinner(players: [player1, player2]);
      PokerPlayer winner = pokerWinner.getWinner();

      // Assert
      expect(winner.name, 'Player 1');
      expect('${PokerRank(cards: winner.hand.cards)}', 'Flush');
    });

    test('Player 1 should win by Straight', () {
      // Arrange
      PokerPlayer player1 = PokerPlayer(name: 'Player 1');
      PokerPlayer player2 = PokerPlayer(name: 'Player 2');

      player1.hand.cards = [
        const PokerCard(suit: CardSuit.clubs, face: '6'),
        const PokerCard(suit: CardSuit.clubs, face: '4'),
        const PokerCard(suit: CardSuit.diamonds, face: '2'),
        const PokerCard(suit: CardSuit.hearts, face: '3'),
        const PokerCard(suit: CardSuit.diamonds, face: '5'),
      ];
      player2.hand.cards = [
        const PokerCard(suit: CardSuit.spades, face: 'Ace'),
        const PokerCard(suit: CardSuit.hearts, face: 'Ace'),
        const PokerCard(suit: CardSuit.spades, face: '10'),
        const PokerCard(suit: CardSuit.spades, face: '2'),
        const PokerCard(suit: CardSuit.diamonds, face: 'Ace'),
      ];

      // Action
      PokerWinner pokerWinner = PokerWinner(players: [player1, player2]);
      PokerPlayer winner = pokerWinner.getWinner();

      // Assert
      expect(winner.name, 'Player 1');
      expect('${PokerRank(cards: winner.hand.cards)}', 'Straight');
    });

    test('Player 1 should win by Three of a Kind', () {
      // Arrange
      PokerPlayer player1 = PokerPlayer(name: 'Player 1');
      PokerPlayer player2 = PokerPlayer(name: 'Player 2');

      player1.hand.cards = [
        const PokerCard(suit: CardSuit.spades, face: 'Ace'),
        const PokerCard(suit: CardSuit.hearts, face: 'Ace'),
        const PokerCard(suit: CardSuit.spades, face: '10'),
        const PokerCard(suit: CardSuit.spades, face: '2'),
        const PokerCard(suit: CardSuit.diamonds, face: 'Ace'),
      ];
      player2.hand.cards = [
        const PokerCard(suit: CardSuit.clubs, face: 'Jack'),
        const PokerCard(suit: CardSuit.clubs, face: 'King'),
        const PokerCard(suit: CardSuit.diamonds, face: 'Jack'),
        const PokerCard(suit: CardSuit.hearts, face: '3'),
        const PokerCard(suit: CardSuit.diamonds, face: 'King'),
      ];

      // Action
      PokerWinner pokerWinner = PokerWinner(players: [player1, player2]);
      PokerPlayer winner = pokerWinner.getWinner();

      // Assert
      expect(winner.name, 'Player 1');
      expect('${PokerRank(cards: winner.hand.cards)}', 'Three of a Kind');
    });

    test('Player 1 should win by Two Pairs', () {
      // Arrange
      PokerPlayer player1 = PokerPlayer(name: 'Player 1');
      PokerPlayer player2 = PokerPlayer(name: 'Player 2');

      player1.hand.cards = [
        const PokerCard(suit: CardSuit.clubs, face: 'Jack'),
        const PokerCard(suit: CardSuit.clubs, face: 'King'),
        const PokerCard(suit: CardSuit.diamonds, face: 'Jack'),
        const PokerCard(suit: CardSuit.hearts, face: '3'),
        const PokerCard(suit: CardSuit.diamonds, face: 'King'),
      ];
      player2.hand.cards = [
        const PokerCard(suit: CardSuit.spades, face: '9'),
        const PokerCard(suit: CardSuit.hearts, face: 'Ace'),
        const PokerCard(suit: CardSuit.spades, face: '10'),
        const PokerCard(suit: CardSuit.spades, face: '8'),
        const PokerCard(suit: CardSuit.diamonds, face: 'Ace'),
      ];

      // Action
      PokerWinner pokerWinner = PokerWinner(players: [player1, player2]);
      PokerPlayer winner = pokerWinner.getWinner();

      // Assert
      expect(winner.name, 'Player 1');
      expect('${PokerRank(cards: winner.hand.cards)}', 'Two Pairs');
    });

    test('Player 1 should win by One Pair', () {
      // Arrange
      PokerPlayer player1 = PokerPlayer(name: 'Player 1');
      PokerPlayer player2 = PokerPlayer(name: 'Player 2');

      player1.hand.cards = [
        const PokerCard(suit: CardSuit.spades, face: '9'),
        const PokerCard(suit: CardSuit.hearts, face: 'Ace'),
        const PokerCard(suit: CardSuit.spades, face: '10'),
        const PokerCard(suit: CardSuit.spades, face: '8'),
        const PokerCard(suit: CardSuit.diamonds, face: 'Ace'),
      ];
      player2.hand.cards = [
        const PokerCard(suit: CardSuit.clubs, face: '6'),
        const PokerCard(suit: CardSuit.clubs, face: 'King'),
        const PokerCard(suit: CardSuit.diamonds, face: 'Jack'),
        const PokerCard(suit: CardSuit.hearts, face: '7'),
        const PokerCard(suit: CardSuit.diamonds, face: '5'),
      ];

      // Action
      PokerWinner pokerWinner = PokerWinner(players: [player1, player2]);
      PokerPlayer winner = pokerWinner.getWinner();

      // Assert
      expect(winner.name, 'Player 1');
      expect('${PokerRank(cards: winner.hand.cards)}', 'One Pair');
    });

    test('Player 1 should win by K♣', () {
      // Arrange
      PokerPlayer player1 = PokerPlayer(name: 'Player 1');
      PokerPlayer player2 = PokerPlayer(name: 'Player 2');

      player1.hand.cards = [
        const PokerCard(suit: CardSuit.clubs, face: '6'),
        const PokerCard(suit: CardSuit.clubs, face: 'King'),
        const PokerCard(suit: CardSuit.diamonds, face: 'Jack'),
        const PokerCard(suit: CardSuit.hearts, face: '7'),
        const PokerCard(suit: CardSuit.diamonds, face: '5'),
      ];
      player2.hand.cards = [
        const PokerCard(suit: CardSuit.spades, face: '9'),
        const PokerCard(suit: CardSuit.hearts, face: '3'),
        const PokerCard(suit: CardSuit.spades, face: '10'),
        const PokerCard(suit: CardSuit.spades, face: '8'),
        const PokerCard(suit: CardSuit.diamonds, face: '4'),
      ];

      // Action
      PokerWinner pokerWinner = PokerWinner(players: [player1, player2]);
      PokerPlayer winner = pokerWinner.getWinner();

      // Assert
      expect(winner.name, 'Player 1');
      expect('${PokerRank(cards: winner.hand.cards)}', 'K♣');
    });
  });
}
