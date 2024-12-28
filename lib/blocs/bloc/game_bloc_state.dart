part of 'game_bloc_bloc.dart';

class GameState {
  final List<String> board;
  final String currentPlayer;
  final bool isGameOver;
  final String? winner;
  final bool isSinglePlayer;

  GameState({
    required this.board,
    required this.currentPlayer,
    this.isGameOver = false,
    this.winner,
    this.isSinglePlayer = false,
  });

  GameState copyWith({
    List<String>? board,
    String? currentPlayer,
    bool? isGameOver,
    String? winner,
    bool? isSinglePlayer,
  }) {
    return GameState(
      board: board ?? this.board,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      isGameOver: isGameOver ?? this.isGameOver,
      winner: winner,
      isSinglePlayer: isSinglePlayer ?? this.isSinglePlayer,
    );
  }
}
