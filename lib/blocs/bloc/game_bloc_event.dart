part of 'game_bloc_bloc.dart';

abstract class GameEvent {}

class InitializeGame extends GameEvent {
  final bool isSinglePlayer;
  InitializeGame({required this.isSinglePlayer});
}

class MarkCell extends GameEvent {
  final int index;
  MarkCell(this.index);
}

class ResetGame extends GameEvent {}
