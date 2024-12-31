part of 'game_bloc_bloc.dart';

abstract class GameEvent {}

class InitializeGame extends GameEvent {
  final bool isSinglePlayer;
  final int gridSize;
  final String? difficulty;

  InitializeGame({
    required this.isSinglePlayer,
    required this.gridSize,
    this.difficulty,
  });
}

class MarkCell extends GameEvent {
  final int index;

  MarkCell(this.index);
}

class ResetGame extends GameEvent {}
