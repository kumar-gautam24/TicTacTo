part of 'game_bloc_bloc.dart';

class GameState {
  final List<String> board;
  final String currentPlayer;
  final bool isGameOver;
  final String? winner;
  final bool isSinglePlayer;
  final int gridSize;
  final String? difficulty;

  GameState({
    required this.board,
    required this.currentPlayer,
    this.isGameOver = false,
    this.winner,
    this.isSinglePlayer = false,
    this.gridSize = 3,
    this.difficulty = 'Easy',
  });

  GameState copyWith({
    List<String>? board,
    String? currentPlayer,
    bool? isGameOver,
    String? winner,
    bool? isSinglePlayer,
    int? gridSize,
    String? difficulty,
  }) {
    return GameState(
      board: board ?? this.board,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      isGameOver: isGameOver ?? this.isGameOver,
      winner: winner,
      isSinglePlayer: isSinglePlayer ?? this.isSinglePlayer,
      gridSize: gridSize ?? this.gridSize,
      difficulty: difficulty ?? this.difficulty,
    );
  }
}
