import 'hand.dart';

class PokerPlayer {
  PokerHand hand = PokerHand();
  String name;
  int wins = 0;

  PokerPlayer({this.name = 'Player'});

  win() => wins += 1;
}
