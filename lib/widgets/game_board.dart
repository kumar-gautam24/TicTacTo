import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc/game_bloc_bloc.dart';

class GameBoard extends StatelessWidget {
  final int gridSize;

  const GameBoard({super.key, required this.gridSize});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        final totalCells = gridSize * gridSize;

        return Center(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridSize,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: totalCells,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.read<GameBloc>().add(MarkCell(index));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      state.board[index],
                      style: TextStyle(
                        fontSize: gridSize < 5 ? 32 : 24, // Adjust font size for larger grids
                        fontWeight: FontWeight.bold,
                        color:
                        state.board[index] == 'X' ? Colors.blue : Colors.red,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
