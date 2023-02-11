part of 'poker_bloc.dart';

abstract class PokerEvent {}

class PokerEventDealCards extends PokerEvent {}

class PokerEventRevealCards extends PokerEvent {}

class PokerEventNextRound extends PokerEvent {}
