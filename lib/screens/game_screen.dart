import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc/game_bloc_bloc.dart';
import '../widgets/game_board.dart';
import '../widgets/palyer_info.dart';


class GameScreen extends StatelessWidget {
  final bool isSinglePlayer;
  final String playerName;
  final String secondPlayerName;

  const GameScreen({
    super.key,
    required this.isSinglePlayer,
    required this.playerName,
    this.secondPlayerName = '',
  });

  @override
  Widget build(BuildContext context) {
    context.read<GameBloc>().add(InitializeGame(isSinglePlayer: isSinglePlayer));
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text(
          isSinglePlayer
              ? '${playerName.isNotEmpty ? "$playerName\'s " : ""}Tic Tac Toe'
              : '${playerName.isNotEmpty ? playerName : "Player 1"} vs '
                '${secondPlayerName.isNotEmpty ? secondPlayerName : "Player 2"}',
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Container(
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
              PlayerInfo(), // Player names can be referenced here too if needed
              const SizedBox(height: 20),
              SizedBox(
                // Increased height for better layout
                height: 500,
                child: GameBoard(),
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
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
