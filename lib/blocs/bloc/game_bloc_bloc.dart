import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_bloc_event.dart';
part 'game_bloc_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc()
      : super(GameState(
    board: List.filled(9, ''),
    currentPlayer: 'X',
    gridSize: 3,
  )) {
    on<InitializeGame>((event, emit) {
      final totalCells = event.gridSize * event.gridSize;

      emit(GameState(
        board: List.filled(totalCells, ''),
        currentPlayer: 'X',
        isSinglePlayer: event.isSinglePlayer,
        gridSize: event.gridSize,
        difficulty: event.difficulty ?? 'Easy',
      ));
    });

    on<MarkCell>((event, emit) {
      final newBoard = List<String>.from(state.board);
      if (newBoard[event.index] == '' && !state.isGameOver) {
        newBoard[event.index] = state.currentPlayer;

        // Check for a winner or switch player
        final winner = checkWinner(newBoard, state.gridSize);
        if (winner != null || !newBoard.contains('')) {
          emit(state.copyWith(
            board: newBoard,
            isGameOver: true,
            winner: winner,
          ));
        } else if (state.isSinglePlayer && state.currentPlayer == 'X') {
          // AI plays
          final aiMove = getBestMove(
            newBoard,
            state.gridSize,
            state.difficulty!,
          );
          newBoard[aiMove] = 'O';
          emit(state.copyWith(
            board: newBoard,
            currentPlayer: 'X',
            isGameOver:
            checkWinner(newBoard, state.gridSize) != null || !newBoard.contains(''),
            winner: checkWinner(newBoard, state.gridSize),
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
      final totalCells = state.gridSize * state.gridSize;
      emit(GameState(
        board: List.filled(totalCells, ''),
        currentPlayer: 'X',
        isSinglePlayer: state.isSinglePlayer,
        gridSize: state.gridSize,
        difficulty: state.difficulty,
      ));
    });
  }

  String? checkWinner(List<String> board, int gridSize) {
    final winningPatterns = generateWinningPatterns(gridSize);

    for (var pattern in winningPatterns) {
      if (board[pattern[0]] != '' &&
          pattern.every((index) => board[index] == board[pattern[0]])) {
        return board[pattern[0]];
      }
    }
    return null;
  }
  List<List<int>> generateWinningPatterns(int gridSize) {
    List<List<int>> patterns = [];

    // Rows
    for (int row = 0; row < gridSize; row++) {
      patterns.add(
        List.generate(gridSize, (col) => row * gridSize + col),
      );
    }

    // Columns
    for (int col = 0; col < gridSize; col++) {
      patterns.add(
        List.generate(gridSize, (row) => row * gridSize + col),
      );
    }

    // Diagonals
    patterns.add(List.generate(gridSize, (i) => i * (gridSize + 1))); // Main diagonal
    patterns.add(List.generate(gridSize, (i) => (i + 1) * (gridSize - 1))); // Anti-diagonal

    return patterns;
  }

  int getBestMove(List<String> board, int gridSize, String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return board.indexWhere((cell) => cell == ''); // Random available move
      case 'Medium':
        return someBasicStrategy(board, gridSize); // Basic AI logic
      case 'Hard':
        return minimax(board, true, 'O'); // Optimal move using Minimax
      default:
        return board.indexWhere((cell) => cell == '');
    }
  }


  int minimax(List<String> board, bool isMaximizing, String currentPlayer) {
    final winner = checkWinner(board, state.gridSize);
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
        int score =
        minimax(board, !isMaximizing, currentPlayer == 'X' ? 'O' : 'X');
        board[i] = '';
        if (bestScore == null ||
            (isMaximizing ? score > bestScore : score < bestScore)) {
          bestScore = score;
        }
      }
    }
    return bestScore!;
  }
  int someBasicStrategy(List<String> board, int gridSize) {
    // Check if the AI can win in the current turn
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        board[i] = 'O'; // AI's marker
        if (checkWinner(board, gridSize) == 'O') {
          board[i] = ''; // Reset the board
          return i; // Return the winning move
        }
        board[i] = ''; // Reset the board
      }
    }

    // Check if the opponent can win in the next turn, and block them
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        board[i] = 'X'; // Opponent's marker
        if (checkWinner(board, gridSize) == 'X') {
          board[i] = ''; // Reset the board
          return i; // Return the blocking move
        }
        board[i] = ''; // Reset the board
      }
    }

    // Otherwise, pick the first available spot
    return board.indexWhere((cell) => cell == '');
  }

}
