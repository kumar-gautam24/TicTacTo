import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_bloc_event.dart';
part 'game_bloc_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameState(board: List.filled(9, ''), currentPlayer: 'X')) {
    on<InitializeGame>((event, emit) {
      emit(GameState(
        board: List.filled(9, ''),
        currentPlayer: 'X',
        isSinglePlayer: event.isSinglePlayer,
      ));
    });

    on<MarkCell>((event, emit) {
      final newBoard = List<String>.from(state.board);
      if (newBoard[event.index] == '' && !state.isGameOver) {
        newBoard[event.index] = state.currentPlayer;

        // Check for a winner or switch player
        final winner = checkWinner(newBoard);
        if (winner != null || !newBoard.contains('')) {
          emit(state.copyWith(
            board: newBoard,
            isGameOver: true,
            winner: winner,
          ));
        } else if (state.isSinglePlayer && state.currentPlayer == 'X') {
          // AI plays
          final aiMove = getBestMove(newBoard, 'O');
          newBoard[aiMove] = 'O';
          emit(state.copyWith(
            board: newBoard,
            currentPlayer: 'X',
            isGameOver: checkWinner(newBoard) != null || !newBoard.contains(''),
            winner: checkWinner(newBoard),
          ));
        } else {
          emit(state.copyWith(
            board: newBoard,
            currentPlayer: state.currentPlayer == 'X' ? 'O' : 'X',
          ));
        }
      }
    });

    on<ResetGame>((event, emit) {
      emit(GameState(
        board: List.filled(9, ''),
        currentPlayer: 'X',
        isSinglePlayer: state.isSinglePlayer,
      ));
    });
  }

  String? checkWinner(List<String> board) {
    const winningPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winningPatterns) {
      if (board[pattern[0]] != '' &&
          board[pattern[0]] == board[pattern[1]] &&
          board[pattern[1]] == board[pattern[2]]) {
        return board[pattern[0]];
      }
    }
    return null;
  }

  int getBestMove(List<String> board, String player) {
    int? bestScore;
    int bestMove = -1;

    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        board[i] = player;
        int score = minimax(board, false, player == 'X' ? 'O' : 'X');
        board[i] = '';
        if (bestScore == null || (player == 'O' ? score > bestScore : score < bestScore)) {
          bestScore = score;
          bestMove = i;
        }
      }
    }
    return bestMove;
  }

  int minimax(List<String> board, bool isMaximizing, String currentPlayer) {
    final winner = checkWinner(board);
    if (winner != null) {
      return winner == 'O' ? 10 : -10;
    }
    if (!board.contains('')) {
      return 0;
    }

    int? bestScore;
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        board[i] = currentPlayer;
        int score = minimax(board, !isMaximizing, currentPlayer == 'X' ? 'O' : 'X');
        board[i] = '';
        if (bestScore == null ||
            (isMaximizing ? score > bestScore : score < bestScore)) {
          bestScore = score;
        }
      }
    }
    return bestScore!;
  }
}
