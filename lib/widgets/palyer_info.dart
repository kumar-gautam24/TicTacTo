import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc/game_bloc_bloc.dart';


class PlayerInfo extends StatelessWidget {
  const PlayerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        final winnerText = state.winner != null
            ? 'Player ${state.winner} Wins!'
            : 'It\'s a Draw!';
        if (state.isGameOver) {
          return Text(
            winnerText,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        } else {
          return Text(
            'Current Player: ${state.currentPlayer}',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          );
        }
      },
    );
  }
}
