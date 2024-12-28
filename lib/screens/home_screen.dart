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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text(
          'Tic Tac Toe',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
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
              TextField(
                controller: _playerOneController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Player 1 Name',
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),
              if (!isSinglePlayer) ...[
                const SizedBox(height: 12),
                TextField(
                  controller: _playerTwoController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Player 2 Name',
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white, // make text white
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GameScreen(
                        isSinglePlayer: isSinglePlayer,
                        playerName: _playerOneController.text??"Player 1",
                        secondPlayerName:
                            isSinglePlayer ? '' : _playerTwoController.text??"Player 2",
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
      ),
    );
  }
}
