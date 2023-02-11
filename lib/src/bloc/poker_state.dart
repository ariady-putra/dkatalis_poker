part of 'poker_bloc.dart';

abstract class PokerState {
  final PokerTable table;

  const PokerState({required this.table});
}

class PokerStateDeckReady extends PokerState {
  const PokerStateDeckReady({required super.table});
}

class PokerStateDealCards extends PokerState {
  const PokerStateDealCards({required super.table});
}

class PokerStateRevealCards extends PokerState {
  final PokerPlayer winner;
  final String winBy;

  const PokerStateRevealCards({
    required super.table,
    required this.winner,
    required this.winBy,
  });
}
