import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/player.dart';
import '../models/table.dart';
import '../util/poker_rank.dart';
import '../util/poker_winner.dart';

part 'poker_event.dart';
part 'poker_state.dart';

class PokerBloc extends Bloc<PokerEvent, PokerState> {
  PokerBloc()
      : super(
          PokerStateDeckReady(
            table: PokerTable(),
          ),
        ) {
    on<PokerEventDealCards>(_dealCards);
    on<PokerEventRevealCards>(_revealCards);
    on<PokerEventNextRound>(_nextRound);
  }

  _dealCards(PokerEventDealCards event, Emitter<PokerState> emit) {
    // Deal 5 cards to all players
    for (int c = 0; c < 5; c++) {
      for (int p = 0; p < state.table.players.length; p++) {
        final card = state.table.deck.cards.removeLast();
        state.table.players[p].hand.dealCard(card);
      }
    }

    emit(
      PokerStateDealCards(table: state.table),
    );
  }

  _revealCards(PokerEventRevealCards event, Emitter<PokerState> emit) {
    // Reveal other player hands
    state.table.players[1].hand.showHand();
    state.table.players[2].hand.showHand();
    state.table.players[3].hand.showHand();

    // Determine winner
    final pokerWinner = PokerWinner(players: state.table.players);
    final winner = pokerWinner.getWinner();

    // Increment player's win count
    final winnerIndex = state.table.players.indexWhere(
      (player) => player.name == winner.name,
    );
    state.table.players[winnerIndex].win();

    emit(
      PokerStateRevealCards(
        table: state.table,
        winner: winner,
        winBy: PokerRank(cards: winner.hand.cards).toString(),
      ),
    );
  }

  _nextRound(PokerEventNextRound event, Emitter<PokerState> emit) {
    // Clear player hands
    for (int p = 0; p < state.table.players.length; p++) {
      final cards = state.table.players[p].hand.cards;
      state.table.discardPile.addAll(cards);
      state.table.players[p].hand.clearCards();
    }

    // Set other player hands face-down
    state.table.players[1].hand.hideHand();
    state.table.players[2].hand.hideHand();
    state.table.players[3].hand.hideHand();

    // Make sure the cards in the deck are sufficient for next round
    if (state.table.deck.cards.length < 20) {
      state.table.discardPile.clear();
      state.table.deck.newDeck();
      state.table.deck.cards.shuffle();
    }

    // Increment round
    state.table.nextRound();

    emit(
      PokerStateDeckReady(table: state.table),
    );
  }
}
