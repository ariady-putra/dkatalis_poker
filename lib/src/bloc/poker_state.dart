part of 'poker_bloc.dart';

abstract class PokerState {
  final PokerTable table;

  const PokerState({required this.table});
}

class PokerStateDeckReady extends PokerState {
  const PokerStateDeckReady({required super.table});
}

class PokerStateCardsDealt extends PokerState {
  const PokerStateCardsDealt({required super.table});
}

class PokerStateCardsRevealed extends PokerState {
  final PokerPlayer winner;
  final String winBy;

  const PokerStateCardsRevealed({
    required super.table,
    required this.winner,
    required this.winBy,
  });
}
