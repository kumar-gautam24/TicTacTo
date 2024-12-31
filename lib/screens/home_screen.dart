import 'package:flutter/material.dart';
import 'game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _playerOneController = TextEditingController();
  final TextEditingController _playerTwoController = TextEditingController();
  bool isSinglePlayer = false;
  int gridSize = 3; // Default grid size
  String difficulty = 'Easy'; // Default difficulty level

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text(
          'Tic Tac Toe',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 100,
            child: Image.asset("assets/launcher.png"),),
            const SizedBox(height: 20),
            SwitchListTile(
              title: Text(
                isSinglePlayer ? 'Single Player' : 'Multiplayer',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              value: isSinglePlayer,
              onChanged: (value) {
                setState(() {
                  isSinglePlayer = value;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<int>(
              value: gridSize,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    gridSize = value;
                  });
                }
              },
              items: [3, 4, 5, 6, 7].map((size) {
                return DropdownMenuItem<int>(
                  value: size,
                  child: Text('Grid: $size x $size'),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Select Grid Size',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
              ),
              style: const TextStyle(color: Colors.white),
              dropdownColor: Colors.deepPurple,
            ),
            const SizedBox(height: 20),
            if (isSinglePlayer)
              DropdownButtonFormField<String>(
                value: difficulty,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      difficulty = value;
                    });
                  }
                },
                items: ['Easy', 'Medium', 'Hard'].map((level) {
                  return DropdownMenuItem<String>(
                    value: level,
                    child: Text('Difficulty: $level'),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'AI Difficulty Level',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                dropdownColor: Colors.deepPurple,
              ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                backgroundColor: Colors.deepPurpleAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GameScreen(
                      isSinglePlayer: isSinglePlayer,
                      playerName: _playerOneController.text,
                      secondPlayerName: isSinglePlayer
                          ? ''
                          : _playerTwoController.text,
                      gridSize: gridSize,
                      difficulty: isSinglePlayer ? difficulty : null,
                    ),
                  ),
                );
              },
              child: const Text(
                'Start Game',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
