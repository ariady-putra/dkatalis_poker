import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/poker_bloc.dart';
import 'deck.dart';
import 'player.dart';

class WidgetTable extends StatefulWidget {
  const WidgetTable({super.key});

  @override
  State<WidgetTable> createState() => _WidgetTableState();
}

class _WidgetTableState extends State<WidgetTable> {
  final ConfettiController _confetti = ConfettiController();

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  String _formatWinning(PokerStateCardsRevealed state) {
    String winnerName = state.winner.name;
    if (winnerName == 'You') {
      winnerName = 'You win';
    } else {
      winnerName = '$winnerName wins'; // Player # wins
    }
    return '$winnerName by ${state.winBy}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokerBloc, PokerState>(
      builder: (context, state) {
        if (state is PokerStateCardsRevealed && state.winner.name == 'You') {
          _confetti.play();
        }
        return Stack(
          children: [
            // Deck
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      'Round ${state.table.round}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  const WidgetDeck(),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      'Deck ${state.table.deck.deckCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    ),
                  ),
                  Text(
                    'Remaining cards: ${state.table.deck.cards.length}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),

            // Player 1 / You
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const WidgetPlayer(
                    playerIndex: 0,
                    cardSizeScale: .5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      '${state.table.players[0].name}'
                      ' | '
                      'Win: ${state.table.players[0].wins}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Player 2
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const RotatedBox(
                    quarterTurns: 1,
                    child: WidgetPlayer(
                      playerIndex: 1,
                      cardSizeScale: .5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      '${state.table.players[1].name}'
                      '\n'
                      'Win: ${state.table.players[1].wins}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Player 3
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const RotatedBox(
                    quarterTurns: 2,
                    child: WidgetPlayer(
                      playerIndex: 2,
                      cardSizeScale: .5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      '${state.table.players[2].name}'
                      ' | '
                      'Win: ${state.table.players[2].wins}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Player 4
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const RotatedBox(
                    quarterTurns: 3,
                    child: WidgetPlayer(
                      playerIndex: 3,
                      cardSizeScale: .5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      '${state.table.players[3].name}'
                      '\n'
                      'Win: ${state.table.players[3].wins}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Blast confetti when the user wins
            Center(
              child: ConfettiWidget(
                confettiController: _confetti,
                blastDirection: -pi * .5,
              ),
            ),

            // Deck ready, next: deal cards
            if (state is PokerStateDeckReady)
              Center(
                child: ElevatedButton(
                  key: const Key('dealButton'),
                  onPressed: () => context.read<PokerBloc>().add(
                        PokerEventDealCards(),
                      ),
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.deepOrangeAccent),
                  ),
                  child: const Text('Deal'),
                ),
              ),

            // Cards dealts, next: reveal cards
            if (state is PokerStateCardsDealt)
              Center(
                child: Card(
                  color: Colors.white.withOpacity(.75),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                              'Cards have been distributed, reveal cards now'),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          key: const Key('cardsDealtNextButton'),
                          onPressed: () => context.read<PokerBloc>().add(
                                PokerEventRevealCards(),
                              ),
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.deepOrangeAccent),
                          ),
                          child: const Text('Next'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Cards revealed, next: next round
            if (state is PokerStateCardsRevealed)
              Center(
                child: Card(
                  color: Colors.white.withOpacity(.75),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            _formatWinning(state),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          key: const Key('cardsRevealedNextButton'),
                          onPressed: () {
                            _confetti.stop();
                            context.read<PokerBloc>().add(
                                  PokerEventNextRound(),
                                );
                          },
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.deepOrangeAccent),
                          ),
                          child: const Text('Next'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
