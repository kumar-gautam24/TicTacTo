import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _boardKey = 'game_board';
  static const String _currentPlayerKey = 'current_player';
  static const String _playerNameKey = 'player_name';

  Future<void> saveGame(List<String> board, String currentPlayer, String playerName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_boardKey, board);
    await prefs.setString(_currentPlayerKey, currentPlayer);
    await prefs.setString(_playerNameKey, playerName);
  }

  Future<Map<String, dynamic>> loadGame() async {
    final prefs = await SharedPreferences.getInstance();
    final board = prefs.getStringList(_boardKey) ?? List.filled(9, '');
    final currentPlayer = prefs.getString(_currentPlayerKey) ?? 'X';
    final playerName = prefs.getString(_playerNameKey) ?? '';
    return {'board': board, 'currentPlayer': currentPlayer, 'playerName': playerName};
  }
}
