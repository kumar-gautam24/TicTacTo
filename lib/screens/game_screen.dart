import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc/game_bloc_bloc.dart';
import '../widgets/game_board.dart';
import '../widgets/palyer_info.dart';

class GameScreen extends StatelessWidget {
  final bool isSinglePlayer;
  final String playerName;
  final String secondPlayerName;
  final int gridSize;
  final String? difficulty;

  const GameScreen({
    super.key,
    required this.isSinglePlayer,
    required this.playerName,
    this.secondPlayerName = '',
    required this.gridSize,
    this.difficulty,
  });

  @override
  Widget build(BuildContext context) {
    context.read<GameBloc>().add(
      InitializeGame(
        isSinglePlayer: isSinglePlayer,
        gridSize: gridSize,
        difficulty: difficulty,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text(
          isSinglePlayer
              ? '${playerName.isNotEmpty ? "$playerName's " : ""}Tic Tac Toe'
              : '${playerName.isNotEmpty ? playerName : "Player 1"} vs '
              '${secondPlayerName.isNotEmpty ? secondPlayerName : "Player 2"}',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.blueGrey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 22),
            PlayerInfo(),
            const SizedBox(height: 2),
            SizedBox(
              height: 500,
              child: GameBoard(gridSize: gridSize),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<GameBloc>().add(ResetGame());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: const Text(
                'Reset Game',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
